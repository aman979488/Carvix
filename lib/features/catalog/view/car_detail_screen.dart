import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:car_market_app/core/theme/app_theme.dart';
import 'package:car_market_app/core/utils/formatters.dart';
import 'package:car_market_app/core/widgets/primary_button.dart';
import 'package:car_market_app/core/widgets/product_image.dart';
import 'package:car_market_app/features/cart/viewmodel/cart_viewmodel.dart';
import 'package:car_market_app/features/catalog/viewmodel/catalog_viewmodel.dart';
import 'package:car_market_app/features/checkout/viewmodel/checkout_viewmodel.dart';
import 'package:car_market_app/features/offer/viewmodel/offer_viewmodel.dart';
import 'package:car_market_app/features/wishlist/viewmodel/wishlist_viewmodel.dart';

class CarDetailScreen extends StatefulWidget {
  const CarDetailScreen({super.key});

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  int _color = 0;
  static const _colors = [Color(0xFF3D8BFF), Color(0xFF555B66), Color(0xFFE0E0E0), Color(0xFF1B2A5E)];

  @override
  Widget build(BuildContext context) {
    final p = context.watch<CatalogViewModel>().selected;
    if (p == null) return const Scaffold(body: Center(child: Text('No car selected')));
    final wish = context.watch<WishlistViewModel>();
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          icon: Icon(wish.isWished(p) ? Icons.favorite : Icons.favorite_border,
              color: wish.isWished(p) ? AppColors.error : null),
          onPressed: () => wish.toggle(p),
        ),
      ]),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ProductImage(type: p.type, size: 200, width: double.infinity),
          const SizedBox(height: 16),
          Text(p.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Row(children: [
            Text(formatPrice(p.price), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Spacer(),
            const Icon(Icons.star, color: Colors.amber, size: 18),
            Text(' ${p.rating} (${p.reviewCount} reviews)'),
          ]),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _Spec(icon: Icons.settings, label: 'Engine', value: p.engine),
              _Spec(icon: Icons.local_gas_station, label: 'Fuel', value: p.fuel),
              _Spec(icon: Icons.speed, label: '0-100 km/h', value: p.acceleration),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Available Colors'),
          const SizedBox(height: 10),
          Row(
            children: List.generate(
              _colors.length,
              (i) => GestureDetector(
                onTap: () => setState(() => _color = i),
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: _colors[i],
                    shape: BoxShape.circle,
                    border: Border.all(color: i == _color ? Colors.white : Colors.transparent, width: 2),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Add to Cart',
            onPressed: () {
              context.read<CartViewModel>().add(p);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart')));
            },
          ),
          const SizedBox(height: 10),
          PrimaryButton(
            label: 'Buy Now',
            outlined: true,
            onPressed: () {
              context.read<CheckoutViewModel>().setSubtotal(p.price);
              context.push('/checkout');
            },
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              context.read<OfferViewModel>().start(p.id);
              context.push('/make-offer');
            },
            child: const Text('Make an Offer'),
          ),
        ],
      ),
    );
  }
}

class _Spec extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const _Spec({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Icon(icon, color: AppColors.accent),
      const SizedBox(height: 4),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
    ]);
  }
}