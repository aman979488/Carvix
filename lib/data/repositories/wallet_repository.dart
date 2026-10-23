import 'package:car_market_app/data/models/wallet_transaction.dart';

abstract class WalletRepository {
  Future<double> getBalance();
  Future<List<WalletTransaction>> getTransactions();
  Future<void> topUp(double amount);
  Future<bool> deduct(double amount, String title);
}

class MockWalletRepository implements WalletRepository {
  double _balance = 299677;
  final List<WalletTransaction> _tx = [];

  @override
  Future<double> getBalance() async => _balance;

  @override
  Future<List<WalletTransaction>> getTransactions() async => List.of(_tx);

  @override
  Future<void> topUp(double amount) async {
    _balance += amount;
    _tx.insert(0, WalletTransaction(id: DateTime.now().toString(), title: 'Top Up Wallet', amount: amount, date: DateTime.now(), isTopUp: true));
  }

  @override
  Future<bool> deduct(double amount, String title) async {
    if (amount > _balance) return false;
    _balance -= amount;
    _tx.insert(0, WalletTransaction(id: DateTime.now().toString(), title: title, amount: amount, date: DateTime.now()));
    return true;
  }
}