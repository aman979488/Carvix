import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/primary_button.dart';

class _Slide {
  const _Slide(this.image, this.title, this.subtitle);
  final String image;
  final String title;
  final String subtitle;
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  static final _slides = [
    _Slide(
      AppAssets.welcome1,
      'Welcome to\nBMW Store',
      'Premium cars, Genuine accessories,\nExclusive merchandise.',
    ),
    _Slide(
      AppAssets.welcome2,
      'Drive Your\nDream Car',
      'Browse the complete BMW lineup\nright from your phone.',
    ),
    _Slide(
      AppAssets.welcome3,
      'Genuine\nAccessories',
      'Upgrade your ride with original\nparts and accessories.',
    ),
    _Slide(
      AppAssets.welcome4,
      'Make an Offer,\nTrack Your Order',
      'Negotiate, pay securely and track\nevery order to your doorstep.',
    ),
  ];

  final _page = PageController();
  int _index = 0;
  Timer? _timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (final slide in _slides) {
      precacheImage(AssetImage(slide.image), context);
    }
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_page.hasClients) return;
      _page.animateToPage(
        (_index + 1) % _slides.length,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _page.dispose();
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
          // Slides: background image + title + subtitle (swipe hote hain)
          PageView.builder(
            controller: _page,
            itemCount: _slides.length,
            allowImplicitScrolling: true,
            onPageChanged: (i) {
              setState(() => _index = i);
              _startTimer(); // swipe ke baad timer reset
            },
            itemBuilder: (_, i) => _SlideView(
              slide: _slides[i],
              topInset: size.height * 0.08 + 32,
            ),
          ),

          // Fixed: dots, button, skip (bottom)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
              child: Column(
                children: [
                  const Spacer(),
                  _Dots(count: _slides.length, index: _index),
                  const SizedBox(height: 26),
                  PrimaryButton(
                    label: 'Get Started',
                    onPressed: () => context.go('/register'),
                  ),
                  const SizedBox(height: 6),
                  TextButton(
                    onPressed: () => context.go('/sign-in'),
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                    child: const Text(
                      'Skip',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SlideView extends StatelessWidget {
  const _SlideView({required this.slide, required this.topInset});

  final _Slide slide;
  final double topInset;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          slide.image,
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
          errorBuilder: (_, __, ___) => const ColoredBox(color: AppColors.bg),
        ),
        // upar aur neeche dark fade (text aur button readable rahe)
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.35, 0.65, 1.0],
              colors: [
                Color(0xE606101F),
                Color(0x9906101F),
                Color(0x1A06101F),
                Color(0xE606101F),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(24, topInset, 24, 0),
          child: Column(
            children: [
              Text(
                slide.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                slide.subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 7),
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? const Color(0xFF5AA9FF) : Colors.transparent,
            border: Border.all(
              color: active ? const Color(0xFF5AA9FF) : Colors.white54,
              width: 1.5,
            ),
            boxShadow: active
                ? const [BoxShadow(color: Color(0x885AA9FF), blurRadius: 8)]
                : null,
          ),
        );
      }),
    );
  }
}