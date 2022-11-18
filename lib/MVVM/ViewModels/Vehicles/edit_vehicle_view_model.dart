import 'package:flutter/widgets.dart';
import 'package:witpark/MVVM/Models/Vehicles/vehicles_model.dart';
import 'package:witpark/MVVM/Models/model_error.dart';
import 'package:witpark/MVVM/Repo/Vehicles/vehicles_service.dart';
import '../../Repo/status.dart';

class EditVehicleModelView extends ChangeNotifier {
  bool _loading = false;
  ModelError? _modelError;

  bool get loading => _loading;
  ModelError? get modelError => _modelError;

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setModelError(ModelError? modelError) {
    _modelError = modelError;
  }

  Future editVehicle(DatumVehicle vehicle) async {
    setLoading(true);
    var response = await VehiclesService.editVehicle(vehicle);
    if (response is Failure) {
      ModelError modelError = ModelError(response.code, response.errorResponse);
      setModelError(modelError);
    }
    setLoading(false);
  }
}
