import 'package:flutter/foundation.dart';
import 'package:car_market_app/data/models/wallet_transaction.dart';
import 'package:car_market_app/data/repositories/wallet_repository.dart';

class WalletViewModel extends ChangeNotifier {
  final WalletRepository _repo;
  WalletViewModel(this._repo);

  double balance = 0;
  List<WalletTransaction> transactions = [];
  String topUpAmount = '';

  double get topUpValue => double.tryParse(topUpAmount) ?? 0;

  Future<void> load() async {
    balance = await _repo.getBalance();
    transactions = await _repo.getTransactions();
    notifyListeners();
  }

  void addDigit(String d) {
    if (topUpAmount.isEmpty && d == '0') return;
    if (topUpAmount.length >= 9) return;
    topUpAmount += d;
    notifyListeners();
  }

  void backspace() {
    if (topUpAmount.isEmpty) return;
    topUpAmount = topUpAmount.substring(0, topUpAmount.length - 1);
    notifyListeners();
  }

  Future<void> topUp() async {
    if (topUpValue <= 0) return;
    await _repo.topUp(topUpValue);
    topUpAmount = '';
    await load();
  }

  Future<bool> pay(double amount, String title) async {
    final ok = await _repo.deduct(amount, title);
    await load();
    return ok;
  }
}