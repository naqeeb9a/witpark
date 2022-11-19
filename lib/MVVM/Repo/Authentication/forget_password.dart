// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:witpark/MVVM/Repo/status.dart';

class ForgetPasswordService {
  static Future<Object> forgetPassword(
      String username, String email, String password) async {
    try {
      var url = Uri.parse("http://witpark.pythonanywhere.com/API/Login_API/");
      var response = await http.post(url, body: {
        'username': username,
        "email": email,
        'newpassword': password
      });
      if (response.statusCode == 200) {
        return Success(response.statusCode, "Success");
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
