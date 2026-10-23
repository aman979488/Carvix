import 'package:flutter/foundation.dart';
import 'package:car_market_app/data/models/cart_item.dart';
import 'package:car_market_app/data/models/product.dart';

class CartViewModel extends ChangeNotifier {
  final List<CartItem> items = [];

  int get count => items.fold<int>(0, (s, i) => s + i.qty);
  double get subtotal => items.fold<double>(0, (s, i) => s + i.product.price * i.qty);
  double get shipping => 0;
  double get total => subtotal + shipping;

  void add(Product p) {
    final i = items.indexWhere((e) => e.product.id == p.id);
    if (i >= 0) {
      items[i].qty++;
    } else {
      items.add(CartItem(p));
    }
    notifyListeners();
  }

  void increase(CartItem item) {
    item.qty++;
    notifyListeners();
  }

  void decrease(CartItem item) {
    if (item.qty > 1) {
      item.qty--;
    } else {
      items.remove(item);
    }
    notifyListeners();
  }

  void clear() {
    items.clear();
    notifyListeners();
  }
}