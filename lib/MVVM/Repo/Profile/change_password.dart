import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:witpark/MVVM/Models/Authentication/login_model.dart';
import 'package:witpark/MVVM/Repo/Authentication/signup_service.dart';

class UpdatePasswordService {
  static Future<Object> updatePassword(
      LoginModel userData, String oldPassword, String newPassword) async {
    try {
      var url = Uri.parse(
          "https://witpark.pythonanywhere.com/API/Update_Password_API/");
      var response = await http.post(
        url,
        body: {
          "username": userData.data!.username,
          "oldpassword": oldPassword,
          "newpassword": newPassword,
        },
      );
      if (response.statusCode == 200) {
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
