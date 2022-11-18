import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:witpark/MVVM/Models/Cities/city_model.dart';
import 'package:witpark/MVVM/Repo/Authentication/signup_service.dart';

class CitiesService {
  static Future<Object> getAllCities() async {
    try {
      var url =
          Uri.parse("http://witpark.pythonanywhere.com/API/AllCities_API/");
      var response = await http.get(
        url,
      );
      if (response.statusCode == 200) {
        return Success(response.statusCode, cityModelFromJson(response.body));
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
