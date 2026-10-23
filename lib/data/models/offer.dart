enum OfferStatus { processing, accepted, rejected }

class Offer {
  final String id, carId;
  final double amount;
  final OfferStatus status;
  const Offer({required this.id, required this.carId, required this.amount, this.status = OfferStatus.processing});

  factory Offer.fromMap(String id, Map<String, dynamic> m) => Offer(
        id: id,
        carId: m['carId'] ?? '',
        amount: (m['amount'] ?? 0).toDouble(),
        status: OfferStatus.values.byName(m['status'] ?? 'processing'),
      );

  Map<String, dynamic> toMap() => {'carId': carId, 'amount': amount, 'status': status.name};
}