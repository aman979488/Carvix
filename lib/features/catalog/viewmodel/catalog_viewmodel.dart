import 'package:flutter/foundation.dart';
import 'package:car_market_app/data/models/product.dart';
import 'package:car_market_app/data/repositories/product_repository.dart';

class CatalogViewModel extends ChangeNotifier {
  final ProductRepository _repo;
  CatalogViewModel(this._repo);

  List<Product> products = [];
  String filter = 'All';
  Product? selected;
  bool isLoading = false;

  List<String> get categories => ['All', ...products.map((p) => p.category).toSet()];

  List<Product> get visible =>
      filter == 'All' ? products : products.where((p) => p.category == filter).toList();

  Future<void> load(ProductType type) async {
    isLoading = true;
    filter = 'All';
    notifyListeners();
    products = await _repo.getProducts(type: type);
    isLoading = false;
    notifyListeners();
  }

  void setFilter(String f) {
    filter = f;
    notifyListeners();
  }

  void select(Product p) {
    selected = p;
    notifyListeners();
  }
}