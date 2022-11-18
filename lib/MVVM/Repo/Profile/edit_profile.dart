import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../Models/Authentication/login_model.dart';
import '../status.dart';

class UpdateProfileService {
  static Future<Object> updateProfile(LoginModel userData) async {
    try {
      var url = Uri.parse(
          "https://witpark.pythonanywhere.com/API/Update_User_API/${userData.data!.username}");
      var response = await http.post(
        url,
        body: {
          "first_name": userData.data!.firstName,
          "last_name": userData.data!.lastName,
          "email": userData.data!.email,
          "city": userData.data!.city,
          "phone": userData.data!.phone
        },
      );
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Updated Profile Successfully !!");
        return Success(response.statusCode, "success");
      }
      return Failure(response.statusCode, "Invalid Response");
    } on HttpException {
      return Failure(101, "No internet");
    } on FormatException {
      return Failure(102, "Invalid format");
    } catch (e) {
      return Failure(103, "Unknown Error");
    }
  }
}
