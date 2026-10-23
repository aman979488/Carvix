import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../viewmodel/auth_viewmodel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  );

  late final Animation<double> _fade = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0, 0.3, curve: Curves.easeOut),
  );

  @override
  void initState() {
    super.initState();
    _controller.forward().whenComplete(_goNext);
  }

  void _goNext() {
    if (!mounted) return;
    final loggedIn = context.read<AuthViewModel>().isLoggedIn;
    context.go(loggedIn ? '/home' : '/welcome');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Car + showroom image (beech se neeche tak)
          Positioned(
            left: 0,
            right: 0,
            top: size.height * 0.40,
            height: size.height * 0.40,
            child: Image.asset(
              AppAssets.splashCar,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          ),

          // 2. Gradient: image ke upar aur neeche bg mein melt ho jaye
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.40, 0.52, 0.78, 0.90],
                colors: [
                  Color(0xFF0A1830),
                  Color(0xFF06101F),
                  Color(0x9906101F),
                  Color(0x9906101F),
                  Color(0xFF06101F),
                ],
              ),
            ),
          ),

          // 3. Content
          SafeArea(
            child: FadeTransition(
              opacity: _fade,
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.12),
                  Container(
                    width: 112,
                    height: 112,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x553D8BFF),
                          blurRadius: 40,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        AppAssets.logo,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.directions_car_filled,
                          size: 80,
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'BMW Store',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Drive Your Passion',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  _LoadingBar(
                    animation: _controller,
                    width: size.width * 0.65,
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'Loading...',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textMuted,
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingBar extends StatelessWidget {
  const _LoadingBar({required this.animation, required this.width});

  final Animation<double> animation;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 6,
      child: AnimatedBuilder(
        animation: animation,
        builder: (_, __) {
          return Stack(
            children: [
              // track
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF16294A),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              // fill with glow
              FractionallySizedBox(
                widthFactor: animation.value.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x883D8BFF),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}