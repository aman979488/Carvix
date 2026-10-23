import 'package:flutter/foundation.dart';
import 'package:car_market_app/core/constants/app_constants.dart';
import 'package:car_market_app/data/models/address.dart';

class CheckoutViewModel extends ChangeNotifier {
  final List<Address> addresses = [
    const Address(id: 'a1', label: 'Home', fullAddress: '123 Main Street, New York, NY 10001'),
    const Address(id: 'a2', label: 'Office', fullAddress: '4570 Meadow Valley Terrace, NY 10012'),
  ];

  double subtotal = 0;
  String paymentMethod = 'card';
  late Address selectedAddress = addresses.first;
  ShippingOption selectedShipping = AppConstants.shippingOptions.first;

  double get shipping => selectedShipping.price;
  double get tax => AppConstants.tax;
  double get total => subtotal + shipping + tax;

  void setSubtotal(double v) {
    subtotal = v;
    notifyListeners();
  }

  void selectAddress(Address a) {
    selectedAddress = a;
    notifyListeners();
  }

  void selectShipping(ShippingOption s) {
    selectedShipping = s;
    notifyListeners();
  }

  void selectPayment(String m) {
    paymentMethod = m;
    notifyListeners();
  }

  void addAddress(Address a) {
    addresses.add(a);
    notifyListeners();
  }
}