import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:car_market_app/core/theme/app_theme.dart';
import 'package:car_market_app/core/utils/formatters.dart';
import 'package:car_market_app/core/widgets/app_card.dart';
import 'package:car_market_app/core/widgets/primary_button.dart';
import 'package:car_market_app/core/widgets/product_image.dart';
import 'package:car_market_app/features/cart/viewmodel/cart_viewmodel.dart';
import 'package:car_market_app/features/checkout/viewmodel/checkout_viewmodel.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: cart.items.isEmpty
          ? const Center(child: Text('Your cart is empty', style: TextStyle(color: AppColors.textMuted)))
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: cart.items.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (_, i) {
                      final item = cart.items[i];
                      return AppCard(
                        child: Row(children: [
                          ProductImage(type: item.product.type, size: 64, width: 80),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(item.product.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                              Text(formatPrice(item.product.price)),
                            ]),
                          ),
                          IconButton(icon: const Icon(Icons.remove_circle_outline), onPressed: () => cart.decrease(item)),
                          Text('${item.qty}'),
                          IconButton(icon: const Icon(Icons.add_circle_outline), onPressed: () => cart.increase(item)),
                        ]),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(children: [
                    _Row('Subtotal', formatPrice(cart.subtotal)),
                    const _Row('Shipping', 'Free'),
                    _Row('Total', formatPrice(cart.total), bold: true),
                    const SizedBox(height: 12),
                    PrimaryButton(
                      label: 'Proceed to Checkout',
                      onPressed: () {
                        context.read<CheckoutViewModel>().setSubtotal(cart.subtotal);
                        context.push('/checkout');
                      },
                    ),
                  ]),
                ),
              ],
            ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label, value;
  final bool bold;
  const _Row(this.label, this.value, {this.bold = false});

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal, fontSize: bold ? 18 : 14);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label, style: style), Text(value, style: style)]),
    );
  }
}