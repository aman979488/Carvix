import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:car_market_app/core/theme/app_theme.dart';
import 'package:car_market_app/core/widgets/primary_button.dart';
import 'package:car_market_app/features/checkout/viewmodel/checkout_viewmodel.dart';
import 'package:car_market_app/features/offer/viewmodel/offer_viewmodel.dart';

class OfferAcceptedScreen extends StatelessWidget {
  const OfferAcceptedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Spacer(),
            const Icon(Icons.check_circle, size: 96, color: AppColors.success),
            const SizedBox(height: 20),
            const Text('Congrats, your offer has been accepted!',
                textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Spacer(),
            PrimaryButton(
              label: 'Proceed to Checkout',
              onPressed: () {
                context.read<CheckoutViewModel>().setSubtotal(context.read<OfferViewModel>().amountValue);
                context.go('/checkout');
              },
            ),
          ],
        ),
      ),
    );
  }
}