import 'package:flutter/widgets.dart';
import 'package:witpark/MVVM/Models/Places/place_model.dart';
import 'package:witpark/MVVM/Models/model_error.dart';
import 'package:witpark/MVVM/Repo/Places/place_service.dart';
import '../../Repo/status.dart';

class PlaceModelView extends ChangeNotifier {
  PlacesModel? _allPlacesModel;
  bool _loading = false;
  ModelError? _modelError;

  bool get loading => _loading;
  PlacesModel? get allPlacesModel => _allPlacesModel;
  ModelError? get modelError => _modelError;

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setPlaceModel(PlacesModel allPlacesModel) {
    _allPlacesModel = allPlacesModel;
  }

  setModelError(ModelError? modelError) {
    _modelError = modelError;
  }

  Future getAllPlaces(String cityId) async {
    setLoading(true);
    var response = await PlacesService.getAllPlaces(cityId);
    if (response is Success) {
      setPlaceModel(response.response as PlacesModel);
    }
    if (response is Failure) {
      ModelError modelError = ModelError(response.code, response.errorResponse);
      setModelError(modelError);
    }
    setLoading(false);
  }
}
