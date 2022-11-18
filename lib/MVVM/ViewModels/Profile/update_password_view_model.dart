import 'package:flutter/widgets.dart';
import 'package:witpark/MVVM/Models/Authentication/login_model.dart';
import 'package:witpark/MVVM/Models/model_error.dart';
import 'package:witpark/MVVM/Repo/Profile/change_password.dart';
import '../../Repo/Authentication/signup_service.dart';

class UpdatePasswordModelView extends ChangeNotifier {
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

  Future updatePasword(
      LoginModel userData, String oldPassword, String newPassword) async {
    setLoading(true);
    var response = await UpdatePasswordService.updatePassword(
        userData, oldPassword, newPassword);

    if (response is Failure) {
      ModelError modelError = ModelError(response.code, response.errorResponse);
      setModelError(modelError);
    }
    setLoading(false);
  }
}
