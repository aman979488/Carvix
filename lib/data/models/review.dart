class Review {
  final String id, userName, comment;
  final double rating;
  final DateTime createdAt;
  const Review({
    required this.id,
    required this.userName,
    required this.comment,
    required this.rating,
    required this.createdAt,
  });

  factory Review.fromMap(String id, Map<String, dynamic> m) => Review(
        id: id,
        userName: m['userName'] ?? '',
        comment: m['comment'] ?? '',
        rating: (m['rating'] ?? 0).toDouble(),
        createdAt: DateTime.fromMillisecondsSinceEpoch(m['createdAt'] ?? 0),
      );

  Map<String, dynamic> toMap() =>
      {'userName': userName, 'comment': comment, 'rating': rating, 'createdAt': createdAt.millisecondsSinceEpoch};
}