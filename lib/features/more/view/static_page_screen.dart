import 'package:flutter/material.dart';

class StaticPageScreen extends StatelessWidget {
  const StaticPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('StaticPageScreen')),
      body: const Center(child: Text('StaticPageScreen - TODO')),
    );
  }
}