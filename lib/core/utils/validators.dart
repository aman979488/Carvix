import 'package:flutter/material.dart';

class Validators {
  static String? name(String? v) =>
      (v == null || v.trim().length < 2) ? 'Enter your full name' : null;

  static String? email(String? v) {
    final ok = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$').hasMatch((v ?? '').trim());
    return ok ? null : 'Enter a valid email';
  }

  static String? phone(String? v) {
    final digits = (v ?? '').replaceAll(RegExp(r'\D'), '');
    return digits.length >= 10 ? null : 'Enter a valid phone number';
  }

  static String? password(String? v) =>
      (v == null || v.length < 6) ? 'Minimum 6 characters' : null;

  static String? Function(String?) confirm(TextEditingController original) =>
      (v) => v == original.text ? null : 'Passwords do not match';
}
