import 'package:flutter/widgets.dart';
import 'package:witpark/MVVM/Models/model_error.dart';
import 'package:witpark/MVVM/Repo/Bookings/booking_service.dart';
import '../../Repo/status.dart';

class CancelBookingModelView extends ChangeNotifier {
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

  Future cancelBooking(String username, String bookingId) async {
    setLoading(true);
    var response = await BookingService.cancelBooking(username, bookingId);

    if (response is Failure) {
      ModelError modelError = ModelError(response.code, response.errorResponse);
      setModelError(modelError);
    }
    setLoading(false);
  }
}
