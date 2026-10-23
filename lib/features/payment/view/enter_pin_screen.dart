import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:car_market_app/core/widgets/num_pad.dart';
import 'package:car_market_app/core/widgets/pin_dots.dart';
import 'package:car_market_app/features/cart/viewmodel/cart_viewmodel.dart';
import 'package:car_market_app/features/checkout/viewmodel/checkout_viewmodel.dart';
import 'package:car_market_app/features/orders/viewmodel/orders_viewmodel.dart';
import 'package:car_market_app/features/payment/viewmodel/payment_viewmodel.dart';

class EnterPinScreen extends StatelessWidget {
  const EnterPinScreen({super.key});

  Future<void> _onDigit(BuildContext context, String d) async {
    final vm = context.read<PaymentViewModel>();
    vm.addDigit(d);
    if (vm.pin.length < 4) return;

    if (!vm.isPinCorrect) {
      vm.clearPin();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Wrong PIN, try again')));
      return;
    }
    vm.clearPin();
    final cart = context.read<CartViewModel>();
    final co = context.read<CheckoutViewModel>();
    final title = cart.items.isEmpty ? 'BMW Order' : cart.items.first.product.name;
    await context.read<OrdersViewModel>().place(title, co.subtotal, co.shipping, co.tax);
    cart.clear();
    if (!context.mounted) return;
    context.go('/order-success');
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PaymentViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Your PIN')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text('Enter your PIN to confirm payment'),
            const SizedBox(height: 24),
            PinDots(filled: vm.pin.length),
            const Spacer(),
            NumPad(onDigit: (d) => _onDigit(context, d), onBackspace: vm.backspace),
          ],
        ),
      ),
    );
  }
}