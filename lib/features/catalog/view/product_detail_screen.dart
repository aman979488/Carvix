import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_market_app/core/utils/formatters.dart';
import 'package:car_market_app/core/widgets/primary_button.dart';
import 'package:car_market_app/core/widgets/product_image.dart';
import 'package:car_market_app/features/cart/viewmodel/cart_viewmodel.dart';
import 'package:car_market_app/features/catalog/viewmodel/catalog_viewmodel.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<CatalogViewModel>().selected;
    if (p == null) return const Scaffold(body: Center(child: Text('No product selected')));
    return Scaffold(
      appBar: AppBar(title: Text(p.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ProductImage(type: p.type, size: 200, width: double.infinity),
          const SizedBox(height: 16),
          Text(p.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(formatPrice(p.price), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Add to Cart',
            onPressed: () {
              context.read<CartViewModel>().add(p);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart')));
            },
          ),
        ],
      ),
    );
  }
}