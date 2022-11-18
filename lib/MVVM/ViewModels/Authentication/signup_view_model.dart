import 'package:flutter/widgets.dart';

import 'package:witpark/MVVM/Models/model_error.dart';
import 'package:witpark/MVVM/Repo/Authentication/signup_service.dart';
import 'package:witpark/MVVM/Views/Authentication/sign_up.dart';

import '../../Repo/status.dart';

class SignupModelView extends ChangeNotifier {
  bool _loading = false;
  ModelError? _modelError;

  SignupModelView() {
    const SignUp();
  }

  bool get loading => _loading;
  ModelError? get modelError => _modelError;
  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setModelError(ModelError? modelError) {
    _modelError = modelError;
  }

  Future signupUser(
    String username,
    String firstname,
    String lastname,
    String email,
    String password,
    String phone,
    String city,
  ) async {
    setLoading(true);
    var response = await SignupPageService.signUpPage(
        username, firstname, lastname, email, password, phone, city);
    if (response is Failure) {
      ModelError modelError = ModelError(response.code, response.errorResponse);
      setModelError(modelError);
    }
    setLoading(false);
  }
}
