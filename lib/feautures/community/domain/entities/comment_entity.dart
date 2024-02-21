class CommentEntity {
  final String userId;
  final String commentId;
  final String username;
  final String? userProfileImage;
  final String commentTime;
  final String commentContent;
  final List<String>? likes;

  CommentEntity({
    required this.userId,
    required this.commentId,
    required this.username,
    required this.userProfileImage,
    required this.commentTime,
    required this.commentContent,
    required this.likes,
  });
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'commentId': commentId,
      'username': username,
      'userProfileImage': userProfileImage,
      'commentTime': commentTime,
      'commentContent': commentContent,
      'likes': likes!.map((like) => like.toString()).toList(),
    };
  }

  factory CommentEntity.fromMap(Map<String, dynamic> map) {
    return CommentEntity(
      userId: map['userId'],
      commentId: map['commentId'],
      username: map['username'],
      userProfileImage: map['userProfileImage'],
      commentTime:map['commentTime'],
      commentContent: map['commentContent'],
      likes: List<String>.from(map['likes'].map((like) => like.toString())),
    );
  }
}