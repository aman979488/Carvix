import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/primary_button.dart';
import '../viewmodel/auth_viewmodel.dart';

class CheckEmailScreen extends StatefulWidget {
  const CheckEmailScreen({super.key, required this.email});
  final String email;

  @override
  State<CheckEmailScreen> createState() => _CheckEmailScreenState();
}

class _CheckEmailScreenState extends State<CheckEmailScreen> {
  static const _cooldown = 30;
  int _left = 0;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCooldown() {
    setState(() => _left = _cooldown);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_left <= 1) {
        t.cancel();
        if (mounted) setState(() => _left = 0);
      } else {
        if (mounted) setState(() => _left--);
      }
    });
  }

  Future<void> _resend() async {
    if (_left > 0 || widget.email.isEmpty) return;
    final vm = context.read<AuthViewModel>();
    final ok = await vm.sendPasswordReset(widget.email);
    if (!mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    if (ok) {
      _startCooldown();
      messenger.showSnackBar(const SnackBar(content: Text('Reset link sent again')));
    } else {
      messenger.showSnackBar(
        SnackBar(
          content: Text(vm.error ?? 'Failed to send reset link'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Spacer(flex: 2),
              const _EnvelopeBadge(),
              const SizedBox(height: 32),
              const Text(
                'Check Your Email',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Text(
                "We've sent a password reset link to\n${widget.email}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 36),
              PrimaryButton(
                label: 'Back to Sign In',
                onPressed: () => context.go(AppRoutes.signIn),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't receive the email? ",
                    style: TextStyle(color: AppColors.textMuted),
                  ),
                  GestureDetector(
                    onTap: _resend,
                    child: Text(
                      _left > 0 ? 'Resend in ${_left}s' : 'Resend',
                      style: TextStyle(
                        color: _left > 0 ? AppColors.textMuted : AppColors.accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}

class _EnvelopeBadge extends StatelessWidget {
  const _EnvelopeBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF0A1E3A),
        border: Border.all(color: AppColors.accent, width: 2),
        boxShadow: const [
          BoxShadow(color: Color(0x553D8BFF), blurRadius: 30),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(Icons.mail, size: 64, color: Color(0xFFEAF1FB)),
          Positioned(
            right: 30,
            bottom: 34,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent,
                border: Border.all(color: const Color(0xFF0A1E3A), width: 2),
              ),
              child: const Icon(Icons.check, size: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
