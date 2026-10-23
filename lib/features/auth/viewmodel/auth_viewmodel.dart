import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:car_market_app/core/constants/app_constants.dart';
import 'package:car_market_app/data/models/app_user.dart';
import 'package:car_market_app/data/repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _repo;
  AuthViewModel(this._repo);

  AppUser? user;
  bool isLoading = false;
  bool isGoogleLoading = false;
  bool isFacebookLoading = false;
  String? error;
  String resetEmail = '';

  bool get isLoggedIn => user != null;

  Future<bool> _run(Future<void> Function() job) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      await job();
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      error = message(e);
      debugPrint('AUTH ERROR: $e');
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  static String message(Object e) {
    if (e is FirebaseAuthException) {
      return switch (e.code) {
        'email-already-in-use' => 'This email is already registered',
        'invalid-email' => 'Invalid email address',
        'weak-password' => 'Password is too weak',
        'wrong-password' || 'user-not-found' || 'invalid-credential' => 'Incorrect email or password',
        'too-many-requests' => 'Too many attempts. Try again later',
        'user-disabled' => 'This account has been disabled',
        'network-request-failed' => 'No internet connection',
        _ => e.message ?? 'Something went wrong',
      };
    }
    final str = e.toString().replaceFirst('Exception: ', '');
    if (str.contains('canceled') || str.contains('sign_in_canceled')) {
      return '';
    }
    return str;
  }

  Future<bool> signIn(String email, String pass) =>
      _run(() async => user = await _repo.signIn(email, pass));

  Future<bool> signInWithGoogle() async {
    isGoogleLoading = true;
    error = null;
    notifyListeners();
    try {
      user = await _repo.signInWithGoogle();
      isGoogleLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      error = message(e);
      debugPrint('GOOGLE AUTH ERROR: $e');
      isGoogleLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signInWithFacebook() async {
    isFacebookLoading = true;
    error = null;
    notifyListeners();
    try {
      final res = await _repo.signInWithFacebook();
      if (res != null) {
        user = res;
      }
      isFacebookLoading = false;
      notifyListeners();
      return res != null;
    } catch (e) {
      error = message(e);
      debugPrint('FACEBOOK AUTH ERROR: $e');
      isFacebookLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String name, String email, String phone, String pass) =>
      _run(() async => user = await _repo.register(
            name: name,
            email: email,
            phone: phone,
            password: pass,
          ));

  Future<bool> sendReset(String email) => _run(() async {
        await _repo.sendResetLink(email);
        resetEmail = email;
      });

  Future<bool> sendPasswordReset(String email) =>
      _run(() => _repo.sendPasswordReset(email));

  Future<bool> verifyOtp(String code) => _run(() async {
        if (!await _repo.verifyOtp(code)) {
          throw Exception('Invalid OTP (demo OTP: ${AppConstants.demoOtp})');
        }
      });

  Future<bool> setNewPassword(String pass) => _run(() => _repo.setNewPassword(pass));

  Future<void> signOut() async {
    await _repo.signOut();
    user = null;
    notifyListeners();
  }
}
