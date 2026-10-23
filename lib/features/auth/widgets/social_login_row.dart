import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';

class SocialLoginRow extends StatelessWidget {
  const SocialLoginRow({
    super.key,
    this.onGoogle,
    this.onApple,
    this.onFacebook,
    this.googleLoading = false,
    this.facebookLoading = false,
  });

  final VoidCallback? onGoogle;
  final VoidCallback? onApple;
  final VoidCallback? onFacebook;
  final bool googleLoading;
  final bool facebookLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _Btn(
          asset: AppAssets.google,
          fallback: Icons.g_mobiledata,
          onTap: googleLoading ? null : onGoogle,
          loading: googleLoading,
        ),
        const SizedBox(width: 18),
        _Btn(asset: AppAssets.apple, fallback: Icons.apple, onTap: onApple),
        const SizedBox(width: 18),
        _Btn(
          asset: AppAssets.facebook,
          fallback: Icons.facebook,
          color: const Color(0xFF1877F2),
          onTap: facebookLoading ? null : onFacebook,
          loading: facebookLoading,
        ),
      ],
    );
  }
}

class _Btn extends StatelessWidget {
  const _Btn({
    required this.asset,
    required this.fallback,
    this.color,
    this.onTap,
    this.loading = false,
  });

  final String asset;
  final IconData fallback;
  final Color? color;
  final VoidCallback? onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 56,
        height: 56,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.card,
          border: Border.all(color: AppColors.border),
        ),
        child: loading
            ? const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            : Image.asset(
                asset,
                errorBuilder: (_, __, ___) =>
                    Icon(fallback, size: 28, color: color ?? Colors.white),
              ),
      ),
    );
  }
}
