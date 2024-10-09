import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/comment_entity.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/community_repository.dart';
import '../datasources/community_remote_data_source.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityRemoteDataSource remoteDataSource;

  CommunityRepositoryImpl({required this.remoteDataSource,});

  @override
  Future<List<DocumentSnapshot>> getPostsBySection(String section, DocumentSnapshot? startAfter) async {
    try {
      return await remoteDataSource.getPostsBySection(section, startAfter);
    } catch (e) {
      print('Error in repository: $e');
      throw e;
    }
  }



// Implement other methods
  @override
  Future<void> addPost(PostEntity post) async {
    try {
      await remoteDataSource.addPost(post);
    } catch (e) {
      print('Error in repository: $e');
      throw Exception('Error adding post');
    }
  }

  @override
  Future<void> likePost(String postId, String userId) async {
    try {
      await remoteDataSource.likePost(postId, userId);
    } catch (e) {
      print('Error in repository: $e');
      throw Exception('Error liking post');
    }
  }

  @override
  Future<void> likeComment(String postId, String userId, String commentId) async {
    try {
      await remoteDataSource.likeComment(postId, userId, commentId);
    } catch (e) {
      print('Error in repository: $e');
      throw Exception('Error liking post');
    }
  }

  @override
  Stream<List<CommentEntity>> streamCommentsForPost(String postId) {
    return remoteDataSource.streamCommentsForPost(postId);
  }

  @override
  Future<void> addComment(String postId, CommentEntity comment) {
    return remoteDataSource.addComment(postId, comment);
  }

  @override
  Future<bool> checkLikeStatusForPost(String postId) {
    return remoteDataSource.checkLikeStatusForPost(postId);
  }

  @override
  Future<bool> checkLikeStatusForComment(String postId, String commentId) {
    return remoteDataSource.checkLikeStatusForComment(postId, commentId);
  }

  @override
  Future<int> getLikeCountForPost(String postId) {
    return remoteDataSource.getLikeCountForPost(postId);
  }

  @override
  Future<int> getLikeCountForComment(String postId, String commentId) {
    return remoteDataSource.getLikeCountForComment(postId, commentId);
  }

  @override
  Future<int> getCommentsCount(String postId) {
    return remoteDataSource.getCommentsCount(postId);
  }

  @override
  Future<void> deletePost(String postId) async {
    try {
      await remoteDataSource.deletePost(postId);
    } catch (e) {
      print('Error in repository: $e');
      throw Exception('Error liking post');
    }
  }

}