import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:witpark/MVVM/Models/Authentication/login_model.dart';
import 'package:witpark/MVVM/Models/model_error.dart';
import '../../Repo/Authentication/signup_service.dart';
import '../../Repo/Profile/edit_profile.dart';

class UpdateProfileModelView extends ChangeNotifier {
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

  Future getAllupdateProfiles(LoginModel userData) async {
    setLoading(true);
    var response = await UpdateProfileService.updateProfile(userData);
    if (response is Success) {
      Fluttertoast.showToast(msg: "Profile Updated Successfully !!");
    }
    if (response is Failure) {
      ModelError modelError = ModelError(response.code, response.errorResponse);
      setModelError(modelError);
    }
    setLoading(false);
  }
}
