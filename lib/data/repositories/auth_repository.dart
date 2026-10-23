import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user.dart';
import '../services/auth_service.dart';

abstract class AuthRepository {
  Future<AppUser> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  });

  Future<AppUser> signIn(String email, String password);
  Future<AppUser> signInWithGoogle();
  Future<AppUser?> signInWithFacebook();
  Future<void> signOut();
  Future<void> sendResetLink(String email);
  Future<void> sendPasswordReset(String email);
  Future<bool> verifyOtp(String code);
  Future<void> setNewPassword(String password);
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._service, this._db);
  final AuthService _service;
  final FirebaseFirestore _db;

  @override
  Future<AppUser> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final user = await _service.register(
      name: name,
      email: email,
      password: password,
    );
    final profile = AppUser(
      uid: user.uid,
      name: name,
      email: email,
      phone: phone,
    );
    await _db.collection('users').doc(user.uid).set(profile.toMap());
    return profile;
  }

  @override
  Future<AppUser> signIn(String email, String password) async {
    final user = await _service.signIn(email: email, password: password);
    final doc = await _db.collection('users').doc(user.uid).get();
    if (doc.exists && doc.data() != null) {
      return AppUser.fromMap(doc.data()!);
    }
    return AppUser(
      uid: user.uid,
      name: user.displayName ?? 'BMW User',
      email: user.email ?? email,
      phone: '',
    );
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    final cred = await _service.signInWithGoogle();
    final user = cred.user!;
    final ref = _db.collection('users').doc(user.uid);
    final doc = await ref.get();
    if (doc.exists && doc.data() != null) {
      return AppUser.fromMap(doc.data()!);
    }
    final profile = AppUser(
      uid: user.uid,
      name: user.displayName ?? 'BMW User',
      email: user.email ?? '',
      phone: user.phoneNumber ?? '',
      photoUrl: user.photoURL,
    );
    await ref.set(profile.toMap());
    return profile;
  }

  @override
  Future<AppUser?> signInWithFacebook() async {
    final cred = await _service.signInWithFacebook();
    if (cred == null) return null;
    final user = cred.user!;
    final ref = _db.collection('users').doc(user.uid);
    final doc = await ref.get();
    if (doc.exists && doc.data() != null) {
      return AppUser.fromMap(doc.data()!);
    }
    final profile = AppUser(
      uid: user.uid,
      name: user.displayName ?? 'Facebook User',
      email: user.email ?? '',
      phone: user.phoneNumber ?? '',
      photoUrl: user.photoURL,
    );
    await ref.set(profile.toMap());
    return profile;
  }

  @override
  Future<void> signOut() => _service.signOut();

  @override
  Future<void> sendResetLink(String email) async {}

  @override
  Future<void> sendPasswordReset(String email) => _service.sendPasswordReset(email);

  @override
  Future<bool> verifyOtp(String code) async => true;

  @override
  Future<void> setNewPassword(String password) async {}
}

class MockAuthRepository implements AuthRepository {
  @override
  Future<AppUser> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (name.trim().isEmpty || email.trim().isEmpty || password.length < 6) {
      throw Exception('Fill all fields (password min 6 chars)');
    }
    return AppUser(
      uid: 'mock_uid_123',
      name: name.trim(),
      email: email.trim(),
      phone: phone.trim(),
    );
  }

  @override
  Future<AppUser> signIn(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (email.trim().isEmpty || password.length < 6) {
      throw Exception('Invalid email or password');
    }
    return AppUser(
      uid: 'mock_uid_123',
      name: 'John Doe',
      email: email.trim(),
      phone: '1234567890',
    );
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return const AppUser(
      uid: 'google_mock_uid',
      name: 'Google User',
      email: 'google@user.com',
      phone: '',
    );
  }

  @override
  Future<AppUser?> signInWithFacebook() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return const AppUser(
      uid: 'fb_mock_uid',
      name: 'Facebook User',
      email: 'fb@user.com',
      phone: '',
    );
  }

  @override
  Future<void> signOut() async {}

  @override
  Future<void> sendResetLink(String email) async {}

  @override
  Future<void> sendPasswordReset(String email) async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  @override
  Future<bool> verifyOtp(String code) async => true;

  @override
  Future<void> setNewPassword(String password) async {}
}
