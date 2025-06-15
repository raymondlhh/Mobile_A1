class Reward {
  final String id;
  final String name;
  final String description;
  final int points;
  final String imagePath;
  final bool isRedeemed;
  final DateTime? redeemedAt;

  Reward({
    required this.id,
    required this.name,
    required this.description,
    required this.points,
    required this.imagePath,
    this.isRedeemed = false,
    this.redeemedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'points': points,
      'imagePath': imagePath,
      'isRedeemed': isRedeemed,
      'redeemedAt': redeemedAt?.toIso8601String(),
    };
  }

  factory Reward.fromMap(String id, Map<String, dynamic> map) {
    return Reward(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      points: map['points'] ?? 0,
      imagePath: map['imagePath'] ?? '',
      isRedeemed: map['isRedeemed'] ?? false,
      redeemedAt:
          map['redeemedAt'] != null ? DateTime.parse(map['redeemedAt']) : null,
    );
  }
}
