import 'package:startup/feautures/community/domain/entities/post_entity.dart';

abstract class PostsRepository {
  Future<List<PostEntity>> getPostsByUserId(String userId);
}