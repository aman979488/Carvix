import 'package:flutter/foundation.dart';
import 'package:car_market_app/data/models/product.dart';
import 'package:car_market_app/data/repositories/product_repository.dart';

class SearchViewModel extends ChangeNotifier {
  final ProductRepository _repo;
  SearchViewModel(this._repo);

  String query = '';
  List<Product> results = [];
  final List<String> recent = ['BMW 3 Series', 'BMW X5', 'BMW Hoodie', 'BMW Cap'];

  // Filters screen ke liye
  double maxPrice = 100000;
  bool onlyNew = true;

  Future<void> search(String q) async {
    query = q;
    results = await _repo.search(q);
    if (q.trim().isNotEmpty && !recent.contains(q.trim())) recent.insert(0, q.trim());
    notifyListeners();
  }

  void setMaxPrice(double v) {
    maxPrice = v;
    notifyListeners();
  }

  void setOnlyNew(bool v) {
    onlyNew = v;
    notifyListeners();
  }
}