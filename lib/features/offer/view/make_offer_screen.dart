import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:car_market_app/core/constants/app_constants.dart';
import 'package:car_market_app/core/theme/app_theme.dart';
import 'package:car_market_app/core/utils/formatters.dart';
import 'package:car_market_app/core/widgets/num_pad.dart';
import 'package:car_market_app/core/widgets/primary_button.dart';
import 'package:car_market_app/features/offer/viewmodel/offer_viewmodel.dart';

class MakeOfferScreen extends StatelessWidget {
  const MakeOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<OfferViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Make an Offer')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Center(
                child: Text(
                  vm.amount.isEmpty ? '\$0' : formatPrice(vm.amountValue),
                  style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: AppConstants.quickOfferAmounts
                  .map((a) => ActionChip(label: Text(formatPrice(a)), onPressed: () => vm.setAmount(a)))
                  .toList(),
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              label: 'Send Offer',
              onPressed: vm.canSend ? () => context.go('/offer-processing') : null,
            ),
            const Spacer(),
            NumPad(onDigit: vm.addDigit, onBackspace: vm.backspace),
          ],
        ),
      ),
    );
  }
}