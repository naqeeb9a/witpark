import 'package:flutter/material.dart';
import 'package:witpark/MVVM/Models/model_error.dart';
import 'package:witpark/MVVM/Repo/Bookings/booking_service.dart';
import '../../Repo/status.dart';

class AddBookingModelView extends ChangeNotifier {
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

  Future getAllBookings(String username, String selectedCity, String amount,
      DateTimeRange dateTimeRange) async {
    setLoading(true);
    var response = await BookingService.bookParkingSlot(
        username, selectedCity, amount, dateTimeRange);
    if (response is Failure) {
      ModelError modelError = ModelError(response.code, response.errorResponse);
      setModelError(modelError);
    }
    setLoading(false);
  }
}
