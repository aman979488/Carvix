import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../viewmodel/auth_viewmodel.dart';
import '../widgets/social_login_row.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    final vm = context.read<AuthViewModel>();
    final ok = await vm.register(
      _name.text.trim(),
      _email.text.trim(),
      _phone.text.trim(),
      _password.text,
    );

    if (!mounted) return;
    if (ok) {
      context.go('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(vm.error ?? 'Registration failed'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Future<void> _google() async {
    final vm = context.read<AuthViewModel>();
    final ok = await vm.signInWithGoogle();
    if (!mounted) return;
    if (ok) {
      context.go('/home');
    } else {
      final msg = AuthViewModel.message(vm.error ?? '');
      if (msg.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg), backgroundColor: AppColors.error),
        );
      }
    }
  }

  Future<void> _facebook() async {
    final vm = context.read<AuthViewModel>();
    final ok = await vm.signInWithFacebook();
    if (!mounted) return;
    if (ok) {
      context.go('/home');
    } else {
      final msg = AuthViewModel.message(vm.error ?? '');
      if (msg.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg), backgroundColor: AppColors.error),
        );
      }
    }
  }

  void _soon() => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Coming soon')),
      );

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AuthViewModel>();

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight - 24),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () => context.go('/welcome'),
                            icon: const Icon(Icons.arrow_back),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ),
                        const SizedBox(height: 4),
                        ClipOval(
                          child: Image.asset(
                            AppAssets.logo,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.directions_car_filled,
                              size: 48,
                              color: AppColors.accent,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Create Account',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Join BMW Store and get exclusive offers.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.textMuted, fontSize: 13, height: 1.3),
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          hint: 'Full Name',
                          icon: Icons.person_outline,
                          controller: _name,
                          validator: Validators.name,
                        ),
                        const SizedBox(height: 10),
                        AppTextField(
                          hint: 'Email Address',
                          icon: Icons.mail_outline,
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          validator: Validators.email,
                        ),
                        const SizedBox(height: 10),
                        AppTextField(
                          hint: 'Phone Number',
                          icon: Icons.phone_outlined,
                          controller: _phone,
                          keyboardType: TextInputType.phone,
                          validator: Validators.phone,
                        ),
                        const SizedBox(height: 10),
                        AppTextField(
                          hint: 'Password',
                          icon: Icons.lock_outline,
                          controller: _password,
                          obscure: true,
                          validator: Validators.password,
                        ),
                        const SizedBox(height: 10),
                        AppTextField(
                          hint: 'Confirm Password',
                          icon: Icons.lock_outline,
                          controller: _confirm,
                          obscure: true,
                          validator: Validators.confirm(_password),
                        ),
                        const SizedBox(height: 16),
                        PrimaryButton(
                          label: 'Sign Up',
                          loading: vm.isLoading && !vm.isGoogleLoading && !vm.isFacebookLoading,
                          onPressed: _submit,
                        ),
                        const SizedBox(height: 14),
                        const _OrDivider(),
                        const SizedBox(height: 12),
                        SocialLoginRow(
                          onGoogle: _google,
                          onApple: _soon,
                          onFacebook: _facebook,
                          googleLoading: vm.isGoogleLoading,
                          facebookLoading: vm.isFacebookLoading,
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account? ',
                              style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                            ),
                            GestureDetector(
                              onTap: () => context.go('/sign-in'),
                              child: const Text(
                                'Log In',
                                style: TextStyle(
                                  color: AppColors.accent,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    const line = Expanded(child: Divider(color: AppColors.border, thickness: 1));
    return const Row(
      children: [
        line,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('or continue with', style: TextStyle(fontSize: 12)),
        ),
        line,
      ],
    );
  }
}
