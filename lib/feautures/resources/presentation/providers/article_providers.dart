import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:startup/feautures/resources/data/datasources/articles_data_source.dart';
import 'package:startup/feautures/resources/data/repositories/articles_repository_impl.dart';
import 'package:startup/feautures/resources/domain/entities/article_entity.dart';
import 'package:startup/feautures/resources/domain/repository/article_repository.dart';

final articleRepositoryProvider = Provider<ArticleRepository>((ref) {
  return ArticleRepositoryImpl(remoteDataSource: ArticleRemoteDataSource());
});

final articlesProvider = FutureProvider.autoDispose<List<ArticleEntity>>((ref) async {
  final repository = ref.read(articleRepositoryProvider);
  try {
    return await repository.getArticles();
  } catch (e) {
    print('Error getting articles: $e');
    throw Exception('Error getting articles');
  }
});