import 'dart:math';
import 'package:car_market_app/data/models/offer.dart';

abstract class OfferRepository {
  Future<Offer> submitOffer(String carId, double amount);
}

class MockOfferRepository implements OfferRepository {
  @override
  Future<Offer> submitOffer(String carId, double amount) async {
    await Future.delayed(const Duration(seconds: 3));
    return Offer(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      carId: carId,
      amount: amount,
      status: Random().nextBool() ? OfferStatus.accepted : OfferStatus.rejected,
    );
  }
}