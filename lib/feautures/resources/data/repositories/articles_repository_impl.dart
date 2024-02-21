import 'package:startup/feautures/resources/data/datasources/articles_data_source.dart';
import 'package:startup/feautures/resources/domain/entities/article_entity.dart';
import 'package:startup/feautures/resources/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleDataSource remoteDataSource;

  ArticleRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ArticleEntity>> getArticles() async {
    try {
      return await remoteDataSource.getArticles();
    } catch (e) {
      print('Error getting articles: $e');
      throw Exception('Error getting articles');
    }
  }
}