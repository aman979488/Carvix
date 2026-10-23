import 'package:flutter/foundation.dart';
import 'package:car_market_app/core/constants/app_constants.dart';

class PaymentViewModel extends ChangeNotifier {
  String pin = '';

  void addDigit(String d) {
    if (pin.length >= 4) return;
    pin += d;
    notifyListeners();
  }

  void backspace() {
    if (pin.isEmpty) return;
    pin = pin.substring(0, pin.length - 1);
    notifyListeners();
  }

  void clearPin() {
    pin = '';
    notifyListeners();
  }

  // Demo PIN. Real app mein secure storage / backend se verify hoga.
  bool get isPinCorrect => pin == AppConstants.demoPin;
}