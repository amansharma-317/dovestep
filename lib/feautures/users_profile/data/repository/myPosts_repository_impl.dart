import 'package:startup/feautures/community/domain/entities/post_entity.dart';
import 'package:startup/feautures/users_profile/data/datasources/myPosts_remote_data_source.dart';
import 'package:startup/feautures/users_profile/domain/repository/myPosts_repostiory.dart';

class PostsRepositoryImpl implements PostsRepository {
  final FirestorePostsRemoteDataSource _remoteDataSource;

  PostsRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<PostEntity>> getPostsByUserId(String userId) async {
    return await _remoteDataSource.getPostsByUserId(userId);
  }
}
