import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:witpark/MVVM/Models/Bookings/all_bookings_model.dart';

import '../status.dart';

class BookingService {
  static Future<Object> getAllBookings(String username) async {
    try {
      var url = Uri.parse(
          "http://witpark.pythonanywhere.com/API/UserBookings_API/$username");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return Success(
            response.statusCode, allBookingsModelFromJson(response.body));
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
