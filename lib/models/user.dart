class User {
  final int? id;
  final String name;
  final String avatar;
  final int points;
  final int level;

  User({
    this.id,
    required this.name,
    required this.avatar,
    required this.points,
    required this.level,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'points': points,
      'level': level,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      avatar: map['avatar'],
      points: map['points'],
      level: map['level'],
    );
  }
}
