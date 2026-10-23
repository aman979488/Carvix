import 'package:flutter/foundation.dart';
import 'package:car_market_app/data/models/product.dart';
import 'package:car_market_app/data/repositories/product_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final ProductRepository _repo;
  HomeViewModel(this._repo);

  List<Product> featured = [];
  bool isLoading = false;

  Future<void> load() async {
    isLoading = true;
    notifyListeners();
    final cars = await _repo.getProducts(type: ProductType.car);
    featured = cars.take(3).toList();
    isLoading = false;
    notifyListeners();
  }
}