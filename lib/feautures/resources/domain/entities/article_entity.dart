// domain/entities/article_entity.dart
class ArticleEntity {
  final String id;
  final String title;
  final String content;
  final String authorName;
  final DateTime timestamp;
  final String link;
  final String tag;
  final String authorImage;
  final String authorAbout;

  ArticleEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.authorName,
    required this.timestamp,
    required this.link,
    required this.tag,
    required this.authorImage,
    required this.authorAbout,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'authorName': authorName,
      'timestamp': timestamp.toUtc().toIso8601String(),
      'link': link,
      'tag': tag,
      'authorImage': authorImage,
      'authorAbout': authorAbout,
    };
  }

  factory ArticleEntity.fromMap(Map<String, dynamic> map) {
    return ArticleEntity(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      authorName: map['authorName'] ?? '',
      timestamp: DateTime.parse(map['timestamp']).toLocal(),
      link: map['link'] ?? '',
      tag: map['tag'],
      authorImage: map['authorImage'] ?? '',
      authorAbout: map['authorAbout'] ?? '',
    );
  }
}
