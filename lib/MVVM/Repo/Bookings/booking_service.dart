import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:witpark/MVVM/Models/Bookings/all_bookings_model.dart';
import 'package:witpark/Utils/utils.dart';

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

  static Future<Object> cancelBooking(String username, String bookingId) async {
    try {
      var url = Uri.parse(
          "https://witpark.pythonanywhere.com/API/BookingCancel_API/$username/$bookingId");
      var response = await http.get(url);

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

  static Future<Object> bookParkingSlot(String username, String selectedCity,
      String amount, DateTimeRange dateTimeRange) async {
    try {
      final dateFormat = DateFormat('yyyy-MM-dd');
      final body = {
        "booking_id": "",
        "booking_owner": username,
        "booking_city": selectedCity,
        "booking_place": selectedPlace,
        "booking_arrival": dateFormat.format(dateTimeRange.start),
        "booking_departure": dateFormat.format(dateTimeRange.end),
        "booking_vehicle": selectedVehicle,
        "booking_amount": amount,
        "booking_payment_date": dateFormat.format(DateTime.now()),
        "booking_status": "active",
        "booking_payment_status": "clear",
        "booking_entrance_time": "null",
        "booking_exit_time": "null"
      };

      var url =
          Uri.parse("http://witpark.pythonanywhere.com/API/Add_Booking_API/");
      var response = await http.post(url, body: body);

      if (response.statusCode == 201) {
        return Success(response.statusCode, "sccuess");
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
