import 'package:flutter/material.dart';
import 'package:car_market_app/data/models/product.dart';
import 'package:car_market_app/features/catalog/widgets/catalog_list.dart';

class MerchandiseScreen extends StatelessWidget {
  const MerchandiseScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      const CatalogList(title: 'Merchandise', type: ProductType.merch, detailRoute: '/product-detail');
}