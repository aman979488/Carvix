import 'package:flutter/foundation.dart';
import 'package:car_market_app/data/models/app_order.dart';
import 'package:car_market_app/data/repositories/order_repository.dart';

class OrdersViewModel extends ChangeNotifier {
  final OrderRepository _repo;
  OrdersViewModel(this._repo);

  List<AppOrder> orders = [];
  String tab = 'All'; // All / Pending / Delivered
  AppOrder? selected;
  bool isLoading = false;

  List<AppOrder> get visible {
    if (tab == 'Pending') return orders.where((o) => !o.isDelivered).toList();
    if (tab == 'Delivered') return orders.where((o) => o.isDelivered).toList();
    return orders;
  }

  Future<void> load() async {
    isLoading = true;
    notifyListeners();
    orders = await _repo.getOrders();
    isLoading = false;
    notifyListeners();
  }

  void setTab(String t) {
    tab = t;
    notifyListeners();
  }

  void select(AppOrder o) {
    selected = o;
    notifyListeners();
  }

  Future<void> place(String title, double amount, double shipping, double tax) async {
    await _repo.createOrder(AppOrder(
      id: 'BMW${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      amount: amount,
      shipping: shipping,
      tax: tax,
      placedAt: DateTime.now(),
    ));
    await load();
  }
}