import 'package:flutter/material.dart';
import 'package:car_market_app/core/theme/app_theme.dart';
import 'package:car_market_app/data/models/product.dart';

/// Real images aane tak placeholder icon dikhata hai.
class ProductImage extends StatelessWidget {
  final ProductType type;
  final double size;
  final double? width;
  const ProductImage({super.key, required this.type, this.size = 72, this.width});

  @override
  Widget build(BuildContext context) {
    final icon = switch (type) {
      ProductType.car => Icons.directions_car,
      ProductType.accessory => Icons.build_circle_outlined,
      ProductType.merch => Icons.checkroom,
    };
    return Container(
      width: width ?? size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Icon(icon, size: size * 0.5, color: AppColors.accent),
    );
  }
}