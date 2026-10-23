import 'package:car_market_app/data/models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts({ProductType? type});
  Future<List<Product>> search(String query);
}

class MockProductRepository implements ProductRepository {
  static const List<Product> _data = [
    Product('c1', 'BMW 3 Series', ProductType.car, 'Sedan', 56000, subtitle: 'Sedan - Petrol', engine: '2.0L', fuel: 'Petrol', acceleration: '8.2s'),
    Product('c2', 'BMW 5 Series', ProductType.car, 'Sedan', 72000, subtitle: 'Sedan - Diesel', engine: '2.0L', fuel: 'Diesel', acceleration: '7.1s'),
    Product('c3', 'BMW X1', ProductType.car, 'SUV', 48000, subtitle: 'SUV - Petrol', engine: '1.5L', fuel: 'Petrol', acceleration: '9.0s'),
    Product('c4', 'BMW X3', ProductType.car, 'SUV', 62000, subtitle: 'SUV - Diesel', engine: '2.0L', fuel: 'Diesel', acceleration: '7.8s'),
    Product('c5', 'BMW X5', ProductType.car, 'SUV', 89000, subtitle: 'SUV - Petrol', engine: '3.0L', fuel: 'Petrol', acceleration: '5.5s'),
    Product('c6', 'BMW M4', ProductType.car, 'Coupe', 79000, subtitle: 'Coupe - Petrol', engine: '3.0L', fuel: 'Petrol', acceleration: '3.9s'),
    Product('a1', 'BMW Key Cover', ProductType.accessory, 'Interior', 49),
    Product('a2', 'Floor Mats', ProductType.accessory, 'Interior', 89),
    Product('a3', 'Car Care Kit', ProductType.accessory, 'Exterior', 79),
    Product('a4', 'Wheel Cleaner', ProductType.accessory, 'Exterior', 29),
    Product('a5', 'Roof Box', ProductType.accessory, 'Performance', 499),
    Product('m1', 'BMW T-Shirt', ProductType.merch, 'Clothing', 39),
    Product('m2', 'Hoodie', ProductType.merch, 'Clothing', 69),
    Product('m3', 'Cap', ProductType.merch, 'Clothing', 29),
    Product('m4', 'Backpack', ProductType.merch, 'Accessories', 89),
    Product('m5', 'Mug', ProductType.merch, 'Lifestyle', 19),
  ];

  @override
  Future<List<Product>> getProducts({ProductType? type}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return type == null ? List.of(_data) : _data.where((p) => p.type == type).toList();
  }

  @override
  Future<List<Product>> search(String query) async {
    final q = query.toLowerCase().trim();
    if (q.isEmpty) return [];
    return _data.where((p) => p.name.toLowerCase().contains(q)).toList();
  }
}