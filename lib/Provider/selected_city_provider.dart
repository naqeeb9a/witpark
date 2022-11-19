import 'package:flutter/cupertino.dart';

class SelectedCityProvider extends ChangeNotifier {
  String selectedCity = "Select a City";
  void setSelectedCity(String value, {bool check = false}) {
    selectedCity = value;
    if (check) {
      notifyListeners();
    }
  }
}
