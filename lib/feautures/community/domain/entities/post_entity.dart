
class PostEntity {
  final String? postId;
  final String? userId;
  String? username;
  final String? profilePicUrl;
  final String? section;
  final String? content;
  final String? timestamp;
  final List<String>? likes;
  //final List<CommentEntity>? comments;

  PostEntity({
    this.postId,
    this.userId,
    this.username,
    this.profilePicUrl,
    this.section,
    this.content,
    required this.timestamp,
    required this.likes,
    //required this.comments,
  });
  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'userId': userId,
      'section': section,
      'username': username,
      'profilePicUrl': profilePicUrl,
      'timestamp': timestamp,
      'content': content,
      'likes': likes!.map((like) => like.toString()).toList(),
      //'comments': comments!.map((comment) => comment.toMap()).toList(),
    };
  }

  factory PostEntity.fromMap(Map<String, dynamic> map,) {
    return PostEntity(
      postId: map['postId'] ?? '',
      userId: map['userId'] ?? '',
      section: map['section'] ?? '',
      username: map['username'] ?? '',
      profilePicUrl: map['profilePicUrl'] ?? '',
      timestamp: map['timestamp'],
      content: map['content'] ?? '',
      likes: List<String>.from(map['likes'].map((like) => like.toString())),
      //comments: List<CommentEntity>.from(
         // map['comments'].map((commentMap) => CommentEntity.fromMap(commentMap))) ?? [],
    );
  }
}