import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:witpark/MVVM/Repo/status.dart';

class SignupPageService {
  static Future<Object> signUpPage(
      String username,
      String firstname,
      String lastname,
      String email,
      String password,
      String phone,
      String city) async {
    try {
      var url = Uri.parse("http://witpark.pythonanywhere.com/API/Signup_API/");
      var response = await http.post(url, body: {
        'username': username,
        'first_name': firstname,
        'last_name': lastname,
        'email': email,
        'password': password,
        'phone': phone,
        'city': city
      });
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
