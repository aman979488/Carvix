import 'package:flutter/material.dart';

class PinDots extends StatelessWidget {
  final int length;
  final int filled;
  const PinDots({super.key, this.length = 4, required this.filled});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (i) => Container(
          margin: const EdgeInsets.all(8),
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i < filled ? Colors.white : Colors.transparent,
            border: Border.all(color: Colors.white54),
          ),
        ),
      ),
    );
  }
}