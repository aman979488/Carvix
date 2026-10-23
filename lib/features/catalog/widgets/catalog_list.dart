import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:car_market_app/core/widgets/product_tile.dart';
import 'package:car_market_app/data/models/product.dart';
import 'package:car_market_app/features/catalog/viewmodel/catalog_viewmodel.dart';

/// Cars, Accessories aur Merchandise teeno isi ek widget se bante hain.
class CatalogList extends StatefulWidget {
  final String title, detailRoute;
  final ProductType type;
  const CatalogList({super.key, required this.title, required this.type, required this.detailRoute});

  @override
  State<CatalogList> createState() => _CatalogListState();
}

class _CatalogListState extends State<CatalogList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => context.read<CatalogViewModel>().load(widget.type));
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CatalogViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () => context.go('/search'))],
      ),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SizedBox(
                  height: 48,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: vm.categories
                        .map((c) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ChoiceChip(
                                label: Text(c),
                                selected: vm.filter == c,
                                onSelected: (_) => vm.setFilter(c),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: vm.visible.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (_, i) {
                      final p = vm.visible[i];
                      return ProductTile(
                        product: p,
                        onTap: () {
                          vm.select(p);
                          context.push(widget.detailRoute);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}