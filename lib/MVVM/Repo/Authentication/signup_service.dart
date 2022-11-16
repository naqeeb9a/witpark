// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:http/http.dart' as http;
import '../../Models/Authentication/login_model.dart';

class SignupPageService {
  static Future<Object> SignUpPage(username,firstname,lastname,email,password,phone,city) async {
    try {
      var url = Uri.parse("http://witpark.pythonanywhere.com/API/Signup_API/");
      var response = await http.post(url,body: {
        'username':username,
        'first_name':firstname,
        'last_name':lastname,
        'email':email,
        'password':password,
        'phone':phone,
        'city':city
      });
      if (response.statusCode == 200) {
        return Success(response.statusCode, loginModelFromJson(response.body));
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

class Failure {
  int code;
  Object errorResponse;
  Failure(this.code, this.errorResponse);
}

class Success {
  int? code;
  late Object response;
  Success(this.code, this.response);
}
