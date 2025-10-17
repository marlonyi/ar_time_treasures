class Capsule {
  final String id;
  final String creatorId;
  final String title;
  final String? description;
  final List<String> mediaUrls; // Fotos/videos
  final double latitude;
  final double longitude;
  final DateTime openDate;
  final bool isPrivate;
  final List<String> allowedUsers; // Para colaborativas
  final int pointsReward;
  final String? hint;
  final bool isOpened;

  Capsule({
    required this.id,
    required this.creatorId,
    required this.title,
    this.description,
    required this.mediaUrls,
    required this.latitude,
    required this.longitude,
    required this.openDate,
    this.isPrivate = false,
    this.allowedUsers = const [],
    this.pointsReward = 10,
    this.hint,
    this.isOpened = false,
  });

  factory Capsule.fromJson(Map<String, dynamic> json) {
    return Capsule(
      id: json['id'],
      creatorId: json['creatorId'],
      title: json['title'],
      description: json['description'],
      mediaUrls: List<String>.from(json['mediaUrls'] ?? []),
      latitude: json['latitude'],
      longitude: json['longitude'],
      openDate: DateTime.parse(json['openDate']),
      isPrivate: json['isPrivate'] ?? false,
      allowedUsers: List<String>.from(json['allowedUsers'] ?? []),
      pointsReward: json['pointsReward'] ?? 10,
      hint: json['hint'],
      isOpened: json['isOpened'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creatorId': creatorId,
      'title': title,
      'description': description,
      'mediaUrls': mediaUrls,
      'latitude': latitude,
      'longitude': longitude,
      'openDate': openDate.toIso8601String(),
      'isPrivate': isPrivate,
      'allowedUsers': allowedUsers,
      'pointsReward': pointsReward,
      'hint': hint,
      'isOpened': isOpened,
    };
  }
}
