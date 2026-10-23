class Address {
  final String id, label, fullAddress;
  const Address({required this.id, required this.label, required this.fullAddress});

  factory Address.fromMap(String id, Map<String, dynamic> m) =>
      Address(id: id, label: m['label'] ?? '', fullAddress: m['fullAddress'] ?? '');

  Map<String, dynamic> toMap() => {'label': label, 'fullAddress': fullAddress};
}