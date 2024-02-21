import 'package:startup/feautures/resources/domain/entities/article_entity.dart';

abstract class ArticleRepository {
  Future<List<ArticleEntity>> getArticles();
}