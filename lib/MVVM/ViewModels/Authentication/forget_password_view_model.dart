import 'package:flutter/widgets.dart';
import 'package:witpark/MVVM/Models/model_error.dart';
import 'package:witpark/MVVM/Repo/Authentication/forget_password.dart';
import 'package:witpark/MVVM/Repo/status.dart';

class ForgetPasswordModelView extends ChangeNotifier {
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

  Future forgetPassword(String username, String email, String password) async {
    setLoading(true);
    var response =
        await ForgetPasswordService.forgetPassword(username, email, password);

    if (response is Failure) {
      ModelError modelError = ModelError(response.code, response.errorResponse);
      setModelError(modelError);
    }
    setLoading(false);
  }
}
