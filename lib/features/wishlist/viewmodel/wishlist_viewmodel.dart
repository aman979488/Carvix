import 'package:flutter/foundation.dart';
import 'package:car_market_app/data/models/product.dart';

class WishlistViewModel extends ChangeNotifier {
  final List<Product> items = [];

  bool isWished(Product p) => items.any((e) => e.id == p.id);

  void toggle(Product p) {
    if (isWished(p)) {
      items.removeWhere((e) => e.id == p.id);
    } else {
      items.add(p);
    }
    notifyListeners();
  }
}