import 'package:flutter/material.dart';
import 'package:car_market_app/data/models/product.dart';
import 'package:car_market_app/features/catalog/widgets/catalog_list.dart';

class AccessoriesScreen extends StatelessWidget {
  const AccessoriesScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      const CatalogList(title: 'Accessories', type: ProductType.accessory, detailRoute: '/product-detail');
}