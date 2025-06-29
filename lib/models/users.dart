class Users {
  final String userId;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String address;
  final int rewardsPoints;
  final DateTime? createdAt;

  Users({
    required this.userId,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    this.rewardsPoints = 0,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'address': address,
      'rewardsPoints': rewardsPoints,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory Users.fromMap(String id, Map<String, dynamic> map) {
    return Users(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      rewardsPoints: map['rewardsPoints'] ?? 0,
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
    );
  }

  // Create a copy of the user with updated fields
  Users copyWith({
    String? userId,
    String? name,
    String? email,
    String? password,
    String? phone,
    String? address,
    int? rewardsPoints,
    DateTime? createdAt,
  }) {
    return Users(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      rewardsPoints: rewardsPoints ?? this.rewardsPoints,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'Users(userId: $userId, name: $name, email: $email, rewardsPoints: $rewardsPoints)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Users && other.userId == userId && other.email == email;
  }

  @override
  int get hashCode {
    return userId.hashCode ^ email.hashCode;
  }
}
