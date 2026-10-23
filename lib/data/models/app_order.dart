enum OrderStatus { placed, processing, shipped, outForDelivery, delivered }

class AppOrder {
  final String id, title;
  final double amount, shipping, tax;
  final OrderStatus status;
  final DateTime placedAt;
  const AppOrder({
    required this.id,
    required this.title,
    required this.amount,
    required this.shipping,
    required this.tax,
    required this.placedAt,
    this.status = OrderStatus.placed,
  });

  double get total => amount + shipping + tax;
  bool get isDelivered => status == OrderStatus.delivered;

  factory AppOrder.fromMap(String id, Map<String, dynamic> m) => AppOrder(
        id: id,
        title: m['title'] ?? '',
        amount: (m['amount'] ?? 0).toDouble(),
        shipping: (m['shipping'] ?? 0).toDouble(),
        tax: (m['tax'] ?? 0).toDouble(),
        placedAt: DateTime.fromMillisecondsSinceEpoch(m['placedAt'] ?? 0),
        status: OrderStatus.values.byName(m['status'] ?? 'placed'),
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'amount': amount,
        'shipping': shipping,
        'tax': tax,
        'placedAt': placedAt.millisecondsSinceEpoch,
        'status': status.name,
      };
}