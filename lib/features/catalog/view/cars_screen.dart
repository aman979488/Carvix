import 'package:flutter/material.dart';
import 'package:car_market_app/data/models/product.dart';
import 'package:car_market_app/features/catalog/widgets/catalog_list.dart';

class CarsScreen extends StatelessWidget {
  const CarsScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      const CatalogList(title: 'BMW Cars', type: ProductType.car, detailRoute: '/car-detail');
}