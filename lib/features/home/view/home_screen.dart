import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:car_market_app/core/theme/app_theme.dart';
import 'package:car_market_app/core/widgets/app_card.dart';
import 'package:car_market_app/core/widgets/product_tile.dart';
import 'package:car_market_app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:car_market_app/features/catalog/viewmodel/catalog_viewmodel.dart';
import 'package:car_market_app/features/home/viewmodel/home_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => context.read<HomeViewModel>().load());
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    final name = context.watch<AuthViewModel>().user?.name ?? 'Guest';
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                const CircleAvatar(child: Icon(Icons.person)),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Hello,', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                const Spacer(),
                IconButton(icon: const Icon(Icons.shopping_cart_outlined), onPressed: () => context.push('/cart')),
                IconButton(icon: const Icon(Icons.notifications_none), onPressed: () => context.push('/notifications')),
              ],
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () => context.go('/search'),
              child: const AppCard(
                child: Row(children: [
                  Icon(Icons.search, color: AppColors.textMuted),
                  SizedBox(width: 10),
                  Text('Search cars, accessories, merch...', style: TextStyle(color: AppColors.textMuted)),
                ]),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 170,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(colors: [AppColors.border, AppColors.card]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('THE ULTIMATE\nDRIVING MACHINE', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(minimumSize: const Size(130, 40)),
                    onPressed: () => context.push('/cars'),
                    child: const Text('Explore Now'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _Cat(icon: Icons.directions_car_outlined, label: 'Cars', route: '/cars'),
                const SizedBox(width: 10),
                _Cat(icon: Icons.build_outlined, label: 'Accessories', route: '/accessories'),
                const SizedBox(width: 10),
                _Cat(icon: Icons.checkroom_outlined, label: 'Merchandise', route: '/merchandise'),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Featured Cars', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Spacer(),
                TextButton(onPressed: () => context.push('/cars'), child: const Text('View All')),
              ],
            ),
            if (vm.isLoading) const Center(child: CircularProgressIndicator()),
            for (final p in vm.featured)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ProductTile(
                  product: p,
                  onTap: () {
                    context.read<CatalogViewModel>().select(p);
                    context.push('/car-detail');
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Cat extends StatelessWidget {
  final IconData icon;
  final String label, route;
  const _Cat({required this.icon, required this.label, required this.route});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => context.push(route),
        child: AppCard(
          child: Column(children: [
            Icon(icon, color: AppColors.accent),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(fontSize: 12)),
          ]),
        ),
      ),
    );
  }
}