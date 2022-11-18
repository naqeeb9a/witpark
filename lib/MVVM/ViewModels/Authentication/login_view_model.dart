import 'package:flutter/widgets.dart';
import 'package:witpark/MVVM/Models/Authentication/login_model.dart';
import 'package:witpark/MVVM/Models/model_error.dart';
import 'package:witpark/MVVM/Repo/status.dart';
import '../../Repo/Authentication/login_service.dart';

class LoginModelView extends ChangeNotifier {
  LoginModel? _loginModel;
  bool _loading = false;
  ModelError? _modelError;

  bool get loading => _loading;
  LoginModel? get loginModel => _loginModel;
  ModelError? get modelError => _modelError;
  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setLoginModel(LoginModel loginModel) {
    _loginModel = loginModel;
  }

  setModelError(ModelError? modelError) {
    _modelError = modelError;
  }

  Future loginUser(String username, String password) async {
    setLoading(true);
    var response = await LoginService.loginUser(username, password);
    if (response is Success) {
      setLoginModel(response.response as LoginModel);
    }
    if (response is Failure) {
      ModelError modelError = ModelError(response.code, response.errorResponse);
      setModelError(modelError);
    }
    setLoading(false);
  }
}
