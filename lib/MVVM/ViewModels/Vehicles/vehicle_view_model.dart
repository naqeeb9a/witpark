import 'package:flutter/widgets.dart';
import 'package:witpark/MVVM/Models/Vehicles/vehicles_model.dart';
import 'package:witpark/MVVM/Models/model_error.dart';
import 'package:witpark/MVVM/Repo/Vehicles/vehicles_service.dart';
import '../../Repo/Authentication/signup_service.dart';

class VehicleModelView extends ChangeNotifier {
  VehiclesModel? _vehiclesModel;
  bool _loading = false;
  ModelError? _modelError;

  bool get loading => _loading;
  VehiclesModel? get vehiclesModel => _vehiclesModel;
  ModelError? get modelError => _modelError;

  VehicleModelView() {
    getAllVehicles();
  }

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

  Future getAllVehicles() async {
    setLoading(true);
    var response = await VehiclesService.getAllVehicles();
    if (response is Success) {
      setVehicleModel(response.response as VehiclesModel);
    }
    if (response is Failure) {
      ModelError modelError = ModelError(response.code, response.errorResponse);
      setModelError(modelError);
    }
    setLoading(false);
  }

  Future addNewVehicle(String ownerName, String carName, String carModel,
      String carColor, String carNumberPlate) async {
    setLoading(true);
    var response = await VehiclesService.addNewVehicle(
        ownerName, carName, carModel, carColor, carNumberPlate);
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
