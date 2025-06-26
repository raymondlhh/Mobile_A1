class Reward {
  final String id;
  final String name;
  final String description;
  final int points;
  final String imagePath;
  final int validity;
  final int
  maxRedemptions; // Maximum number of times this reward can be redeemed per user

  Reward({
    required this.id,
    required this.name,
    required this.description,
    required this.points,
    required this.imagePath,
    required this.validity,
    required this.maxRedemptions,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'points': points,
      'imagePath': imagePath,
      'validity': validity,
      'maxRedemptions': maxRedemptions,
    };
  }

  factory Reward.fromMap(String id, Map<String, dynamic> map) {
    return Reward(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      points: map['points'] ?? 0,
      imagePath: map['imagePath'] ?? '',
      validity: map['validity'] ?? 0,
      maxRedemptions: map['maxRedemptions'] ?? 1,
    );
  }
}
