import 'package:flutter/widgets.dart';
import 'package:witpark/MVVM/Models/Bookings/all_bookings_model.dart';
import 'package:witpark/MVVM/Models/model_error.dart';
import 'package:witpark/MVVM/Repo/Bookings/booking_service.dart';
import '../../Repo/Authentication/signup_service.dart';

class BookingModelView extends ChangeNotifier {
  AllBookingsModel? _allBookingsModel;
  bool _loading = false;
  ModelError? _modelError;

  bool get loading => _loading;
  AllBookingsModel? get allBookingsModel => _allBookingsModel;
  ModelError? get modelError => _modelError;

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setBookingModel(AllBookingsModel allBookingsModel) {
    _allBookingsModel = allBookingsModel;
  }

  setModelError(ModelError? modelError) {
    _modelError = modelError;
  }

  Future getAllBookings(String username) async {
    setLoading(true);
    var response = await BookingService.getAllBookings(username);
    if (response is Success) {
      setBookingModel(response.response as AllBookingsModel);
    }
    if (response is Failure) {
      ModelError modelError = ModelError(response.code, response.errorResponse);
      setModelError(modelError);
    }
    setLoading(false);
  }
}
