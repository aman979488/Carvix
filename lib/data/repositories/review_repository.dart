import 'package:car_market_app/data/models/review.dart';

abstract class ReviewRepository {
  Future<List<Review>> getReviews();
  Future<void> addReview(Review review);
}

class MockReviewRepository implements ReviewRepository {
  final List<Review> _reviews = [
    Review(id: 'r1', userName: 'Darlene Robertson', comment: 'Great service, car was as described.', rating: 5, createdAt: DateTime(2025, 4, 1)),
    Review(id: 'r2', userName: 'Jenny Wilson', comment: 'Delivery was a bit late but all good.', rating: 4, createdAt: DateTime(2025, 4, 10)),
  ];

  @override
  Future<List<Review>> getReviews() async => List.of(_reviews);

  @override
  Future<void> addReview(Review review) async => _reviews.insert(0, review);
}