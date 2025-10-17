class User {
  final String id;
  final String email;
  final String displayName;
  final String? avatarUrl;
  final int totalPoints;
  final int level;
  final List<String> badges;
  final List<String> openedCapsules;

  User({
    required this.id,
    required this.email,
    required this.displayName,
    this.avatarUrl,
    this.totalPoints = 0,
    this.level = 1,
    this.badges = const [],
    this.openedCapsules = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      displayName: json['displayName'],
      avatarUrl: json['avatarUrl'],
      totalPoints: json['totalPoints'] ?? 0,
      level: json['level'] ?? 1,
      badges: List<String>.from(json['badges'] ?? []),
      openedCapsules: List<String>.from(json['openedCapsules'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'avatarUrl': avatarUrl,
      'totalPoints': totalPoints,
      'level': level,
      'badges': badges,
      'openedCapsules': openedCapsules,
    };
  }

  User copyWith({
    String? displayName,
    String? avatarUrl,
    int? totalPoints,
    int? level,
    List<String>? badges,
    List<String>? openedCapsules,
  }) {
    return User(
      id: id,
      email: email,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      totalPoints: totalPoints ?? this.totalPoints,
      level: level ?? this.level,
      badges: badges ?? this.badges,
      openedCapsules: openedCapsules ?? this.openedCapsules,
    );
  }
}
