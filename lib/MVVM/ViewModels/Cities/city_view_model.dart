import 'package:flutter/widgets.dart';
import 'package:witpark/MVVM/Models/Cities/city_model.dart';
import 'package:witpark/MVVM/Models/model_error.dart';
import 'package:witpark/MVVM/Repo/Cities/city_service.dart';
import '../../Repo/Authentication/signup_service.dart';

class CityModelView extends ChangeNotifier {
  CityModel? _allcitysModel;
  bool _loading = false;
  ModelError? _modelError;

  bool get loading => _loading;
  CityModel? get allcitysModel => _allcitysModel;
  ModelError? get modelError => _modelError;

  CityModelView() {
    getAllcitys();
  }

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setcityModel(CityModel allcitysModel) {
    _allcitysModel = allcitysModel;
  }

  setModelError(ModelError? modelError) {
    _modelError = modelError;
  }

  Future getAllcitys() async {
    setLoading(true);
    var response = await CitiesService.getAllCities();
    if (response is Success) {
      setcityModel(response.response as CityModel);
    }
    if (response is Failure) {
      ModelError modelError = ModelError(response.code, response.errorResponse);
      setModelError(modelError);
    }
    setLoading(false);
  }
}
