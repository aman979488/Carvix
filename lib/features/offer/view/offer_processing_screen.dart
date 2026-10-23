import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:car_market_app/data/models/offer.dart';
import 'package:car_market_app/features/offer/viewmodel/offer_viewmodel.dart';

class OfferProcessingScreen extends StatefulWidget {
  const OfferProcessingScreen({super.key});

  @override
  State<OfferProcessingScreen> createState() => _OfferProcessingScreenState();
}

class _OfferProcessingScreenState extends State<OfferProcessingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final status = await context.read<OfferViewModel>().sendOffer();
      if (!mounted) return;
      context.go(status == OfferStatus.accepted ? '/offer-accepted' : '/offer-rejected');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 24),
            Text('Your offer is being processed', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}