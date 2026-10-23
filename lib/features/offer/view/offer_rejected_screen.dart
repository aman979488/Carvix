import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:car_market_app/core/theme/app_theme.dart';
import 'package:car_market_app/core/widgets/primary_button.dart';
import 'package:car_market_app/features/offer/viewmodel/offer_viewmodel.dart';

class OfferRejectedScreen extends StatelessWidget {
  const OfferRejectedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Spacer(),
            const Icon(Icons.cancel, size: 96, color: AppColors.error),
            const SizedBox(height: 20),
            const Text("We're sorry, your offer has been rejected",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Spacer(),
            PrimaryButton(
              label: 'Make an Offer Again',
              onPressed: () {
                final vm = context.read<OfferViewModel>();
                vm.start(vm.carId);
                context.go('/make-offer');
              },
            ),
            const SizedBox(height: 12),
            TextButton(onPressed: () => context.go('/home'), child: const Text('Back to Home')),
          ],
        ),
      ),
    );
  }
}