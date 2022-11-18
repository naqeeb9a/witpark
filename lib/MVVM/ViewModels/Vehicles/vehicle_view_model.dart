import 'package:flutter/widgets.dart';
import 'package:witpark/MVVM/Models/Vehicles/vehicles_model.dart';
import 'package:witpark/MVVM/Models/model_error.dart';
import 'package:witpark/MVVM/Repo/Vehicles/vehicles_service.dart';
import '../../Repo/status.dart';

class VehicleModelView extends ChangeNotifier {
  VehiclesModel? _vehiclesModel;
  bool _loading = false;
  ModelError? _modelError;

  bool get loading => _loading;
  VehiclesModel? get vehiclesModel => _vehiclesModel;
  ModelError? get modelError => _modelError;

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setVehicleModel(VehiclesModel vehiclesModel) {
    _vehiclesModel = vehiclesModel;
  }

  setModelError(ModelError? modelError) {
    _modelError = modelError;
  }

  Future getAllVehicles(String username) async {
    setLoading(true);
    var response = await VehiclesService.getAllVehicles(username);
    if (response is Success) {
      setVehicleModel(response.response as VehiclesModel);
    }
    if (response is Failure) {
      ModelError modelError = ModelError(response.code, response.errorResponse);
      setModelError(modelError);
    }
    setLoading(false);
  }
}
