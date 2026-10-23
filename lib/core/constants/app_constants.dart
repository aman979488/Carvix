class ShippingOption {
  final String name;
  final double price;
  const ShippingOption(this.name, this.price);
}

class AppConstants {
  static const double tax = 128;
  static const String demoPin = '1234';
  static const String demoOtp = '123456';
  static const List<double> quickOfferAmounts = [
    50000, 52000, 54000, 55000, 56000,
  ];
  static const List<ShippingOption> shippingOptions = [
    ShippingOption('Standard (Free)', 0),
    ShippingOption('Truck', 200),
    ShippingOption('Train', 250),
    ShippingOption('Plane', 400),
  ];
}