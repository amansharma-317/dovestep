import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/article_entity.dart';


abstract class ArticleDataSource {
  Future<List<ArticleEntity>> getArticles();
}

class ArticleRemoteDataSource implements ArticleDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<ArticleEntity>> getArticles() async {
    try {
      final querySnapshot = await _firestore.collection('articles').get();
      final articles = querySnapshot.docs
          .map((doc) => ArticleEntity(
        id: doc.id,
        title: doc['title'] as String,
        content: doc['content'] as String,
        authorName: doc['authorName'] as String,
        timestamp: DateTime.parse(doc['timestamp'] as String),
        link: doc['link'] as String,
        tag: doc['tag'] as String,
        authorImage: doc['authorImage'] as String,
        authorAbout: doc['authorAbout'] as String,
      ))
          .toList();
      return articles;
    } catch (e) {
      print('Error fetching articles: $e');
      throw Exception('Error fetching articles');
    }
  }
}