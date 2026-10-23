class AppUser {
  const AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    this.photoUrl,
  });

  final String uid;
  final String name;
  final String email;
  final String phone;
  final String? photoUrl;

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'name': name,
    'email': email,
    'phone': phone,
    'photoUrl': photoUrl,
  };

  factory AppUser.fromMap(Map<String, dynamic> m) => AppUser(
    uid: m['uid'] ?? '',
    name: m['name'] ?? '',
    email: m['email'] ?? '',
    phone: m['phone'] ?? '',
    photoUrl: m['photoUrl'],
  );
}