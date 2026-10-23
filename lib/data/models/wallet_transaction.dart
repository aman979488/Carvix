class WalletTransaction {
  final String id, title;
  final double amount;
  final DateTime date;
  final bool isTopUp;
  const WalletTransaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    this.isTopUp = false,
  });

  factory WalletTransaction.fromMap(String id, Map<String, dynamic> m) => WalletTransaction(
        id: id,
        title: m['title'] ?? '',
        amount: (m['amount'] ?? 0).toDouble(),
        date: DateTime.fromMillisecondsSinceEpoch(m['date'] ?? 0),
        isTopUp: m['isTopUp'] ?? false,
      );

  Map<String, dynamic> toMap() =>
      {'title': title, 'amount': amount, 'date': date.millisecondsSinceEpoch, 'isTopUp': isTopUp};
}