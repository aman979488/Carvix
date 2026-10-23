import 'package:flutter/foundation.dart';
import 'package:car_market_app/data/models/offer.dart';
import 'package:car_market_app/data/repositories/offer_repository.dart';

class OfferViewModel extends ChangeNotifier {
  final OfferRepository _repo;
  OfferViewModel(this._repo);

  String carId = '';
  String amount = '';
  OfferStatus? result;

  double get amountValue => double.tryParse(amount) ?? 0;
  bool get canSend => amountValue > 0;

  void start(String id) {
    carId = id;
    amount = '';
    result = null;
    notifyListeners();
  }

  void addDigit(String d) {
    if (amount.isEmpty && d == '0') return;
    if (amount.length >= 9) return;
    amount += d;
    notifyListeners();
  }

  void backspace() {
    if (amount.isEmpty) return;
    amount = amount.substring(0, amount.length - 1);
    notifyListeners();
  }

  void setAmount(double v) {
    amount = v.toStringAsFixed(0);
    notifyListeners();
  }

  Future<OfferStatus> sendOffer() async {
    final offer = await _repo.submitOffer(carId, amountValue);
    result = offer.status;
    notifyListeners();
    return offer.status;
  }
}