import 'package:flutter/material.dart';

class NumPad extends StatelessWidget {
  final void Function(String digit) onDigit;
  final VoidCallback onBackspace;
  const NumPad({super.key, required this.onDigit, required this.onBackspace});

  @override
  Widget build(BuildContext context) {
    const keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '', '0', '<'];
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 2,
      physics: const NeverScrollableScrollPhysics(),
      children: keys.map((k) {
        if (k.isEmpty) return const SizedBox();
        return InkWell(
          onTap: () => k == '<' ? onBackspace() : onDigit(k),
          child: Center(
            child: k == '<'
                ? const Icon(Icons.backspace_outlined)
                : Text(k, style: const TextStyle(fontSize: 24)),
          ),
        );
      }).toList(),
    );
  }
}