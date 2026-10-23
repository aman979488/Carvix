import 'package:car_market_app/data/models/app_order.dart';

abstract class OrderRepository {
  Future<List<AppOrder>> getOrders();
  Future<void> createOrder(AppOrder order);
}

class MockOrderRepository implements OrderRepository {
  final List<AppOrder> _orders = [
    AppOrder(id: 'o1', title: 'BMW 3 Series', amount: 56000, shipping: 0, tax: 128, placedAt: DateTime(2025, 4, 15), status: OrderStatus.delivered),
    AppOrder(id: 'o2', title: 'BMW T-Shirt', amount: 39, shipping: 0, tax: 0, placedAt: DateTime(2025, 4, 10), status: OrderStatus.delivered),
    AppOrder(id: 'o3', title: 'Floor Mats', amount: 89, shipping: 0, tax: 0, placedAt: DateTime(2025, 4, 14), status: OrderStatus.shipped),
  ];

  @override
  Future<List<AppOrder>> getOrders() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List.of(_orders);
  }

  @override
  Future<void> createOrder(AppOrder order) async => _orders.insert(0, order);
}