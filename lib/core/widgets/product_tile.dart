import 'package:flutter/material.dart';
import 'package:car_market_app/core/theme/app_theme.dart';
import 'package:car_market_app/core/utils/formatters.dart';
import 'package:car_market_app/core/widgets/app_card.dart';
import 'package:car_market_app/core/widgets/product_image.dart';
import 'package:car_market_app/data/models/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  const ProductTile({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AppCard(
        child: Row(
          children: [
            ProductImage(type: product.type, size: 64, width: 84),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatPrice(product.price),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (product.subtitle.isNotEmpty)
                    Text(
                      product.subtitle,
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}
