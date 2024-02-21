class HotlineEntity {
  final String? userId;
  final String timestamp;

  HotlineEntity({
    required this.userId,
    required this.timestamp,
  });

  // Convert from a map to a HotlineEntity instance
  factory HotlineEntity.fromMap(Map<String, dynamic> map) {
    return HotlineEntity(
      userId: map['userId'],
      timestamp: map['timestamp'],
    );
  }

  // Convert a HotlineEntity instance to a map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'timestamp': timestamp,
    };
  }
}
