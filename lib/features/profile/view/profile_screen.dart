import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:car_market_app/core/theme/app_colors.dart';
import 'package:car_market_app/core/widgets/primary_button.dart';
import 'package:car_market_app/features/auth/viewmodel/auth_viewmodel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authVm = context.watch<AuthViewModel>();
    final user = authVm.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: AppColors.card,
                child: Icon(Icons.person, size: 48, color: AppColors.accent),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                user?.name ?? 'BMW User',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 6),
            Center(
              child: Text(
                user?.email ?? 'No email',
                style: const TextStyle(color: AppColors.textMuted, fontSize: 14),
              ),
            ),
            const SizedBox(height: 32),
            if (user?.phone != null && user!.phone.isNotEmpty) ...[
              ListTile(
                leading: const Icon(Icons.phone_outlined, color: AppColors.accent),
                title: const Text('Phone Number'),
                subtitle: Text(user.phone),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                tileColor: AppColors.card,
              ),
              const SizedBox(height: 12),
            ],
            ListTile(
              leading: const Icon(Icons.shopping_bag_outlined, color: AppColors.accent),
              title: const Text('My Orders'),
              trailing: const Icon(Icons.chevron_right),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              tileColor: AppColors.card,
              onTap: () => context.push('/orders'),
            ),
            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.favorite_border, color: AppColors.accent),
              title: const Text('Wishlist'),
              trailing: const Icon(Icons.chevron_right),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              tileColor: AppColors.card,
              onTap: () => context.push('/wishlist'),
            ),
            const SizedBox(height: 40),
            PrimaryButton(
              label: 'Log Out',
              onPressed: () async {
                await authVm.signOut();
                if (context.mounted) {
                  context.go('/welcome');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
