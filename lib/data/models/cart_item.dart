import 'package:car_market_app/data/models/product.dart';

class CartItem {
  final Product product;
  int qty;
  CartItem(this.product, [this.qty = 1]);
}