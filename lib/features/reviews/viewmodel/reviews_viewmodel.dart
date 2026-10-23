import 'package:flutter/foundation.dart';
import 'package:car_market_app/data/models/review.dart';
import 'package:car_market_app/data/repositories/review_repository.dart';

class ReviewsViewModel extends ChangeNotifier {
  final ReviewRepository _repo;
  ReviewsViewModel(this._repo);

  List<Review> reviews = [];
  int? starFilter; // null = All

  List<Review> get filtered =>
      starFilter == null ? reviews : reviews.where((r) => r.rating.round() == starFilter).toList();

  double get average =>
      reviews.isEmpty ? 0 : reviews.map((r) => r.rating).reduce((a, b) => a + b) / reviews.length;

  Future<void> load() async {
    reviews = await _repo.getReviews();
    notifyListeners();
  }

  void setFilter(int? star) {
    starFilter = star;
    notifyListeners();
  }
}