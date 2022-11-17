import 'package:flutter/widgets.dart';

import 'package:witpark/MVVM/Models/Authentication/signup_model.dart';
import 'package:witpark/MVVM/Models/model_error.dart';
import 'package:witpark/MVVM/Repo/Authentication/signup_service.dart';
import 'package:witpark/MVVM/Views/Authentication/sign_up.dart';

class SignupModelView extends ChangeNotifier {
  SignUpModel? _signupModel;
  bool _loading = false;
  ModelError? _modelError;

  SignupModelView() {
    const SignUp();
  }

  bool get loading => _loading;
  SignUpModel? get signUpModel => _signupModel;
  ModelError? get modelError => _modelError;
  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setSignupModel(SignUpModel signUpModel) {
    _signupModel = signUpModel;
  }

  setModelError(ModelError? modelError) {
    _modelError = modelError;
  }

  Future signupUser(
      username, firstname, lastname, email, phone, city, password) async {
    setLoading(true);
    var response = await SignupPageService.SignUpPage(
        username, firstname, lastname, email, phone, city, password);
    if (response is Success) {
      setSignupModel(response.response as SignUpModel);
    }
    if (response is Failure) {
      ModelError modelError = ModelError(response.code, response.errorResponse);
      setModelError(modelError);
    }
    setLoading(false);
  }
}
