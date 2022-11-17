// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:witpark/MVVM/Models/Vehicles/vehicles_model.dart';
import 'package:witpark/MVVM/Repo/Authentication/signup_service.dart';

class VehiclesService {
  static Future<Object> getAllVehicles() async {
    try {
      var url =
          Uri.parse("http://witpark.pythonanywhere.com/API/AllVehicles_API/");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return Success(
            response.statusCode, vehiclesModelFromJson(response.body));
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

  static Future<Object> addNewVehicle(String ownerName, String carName,
      String carModel, String carColor, String carNumberPlate) async {
    try {
      var url =
          Uri.parse("http://witpark.pythonanywhere.com/API/Add_Vehicle_API/");
      var response = await http.post(url, body: {
        "vehicle_owner": ownerName,
        "vehicle_name": carName,
        "vehicle_model": carModel,
        "vehicle_color": carColor,
        "vehicle_no_plate": carNumberPlate
      });
      if (response.statusCode == 201) {
        return Success(response.statusCode, "Created");
      }
      return Failure(response.statusCode, "Invalid Response");
    } on HttpException {
      return Failure(101, "No internet");
    } on FormatException {
      return Failure(102, "Invalid format");
    } catch (e) {
      print(e);
      return Failure(103, "Unknown Error");
    }
  }
}
