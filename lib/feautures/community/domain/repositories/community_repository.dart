import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startup/feautures/community/domain/entities/comment_entity.dart';
import 'package:startup/feautures/community/domain/entities/post_entity.dart';

abstract class CommunityRepository {
  Future<List<DocumentSnapshot>> getPostsBySection(String section, DocumentSnapshot? startAfter);
  Future<void> addPost(PostEntity post);
  Future<void> likePost(String postId, String userId);
  Future<void> likeComment(String postId, String userId, String commentId);
  Stream<List<CommentEntity>> streamCommentsForPost(String postId);
  Future<void> addComment(String postId, CommentEntity comment);
  Future<bool> checkLikeStatusForPost(String postId);
  Future<bool> checkLikeStatusForComment(String postId, String commentId);
  Future<int> getLikeCountForPost(String postId);
  Future<int> getLikeCountForComment(String postId, String commentId);
  Future<int> getCommentsCount(String postId);
  Future<void> deletePost(String postId);
 // Future<Either<Failure, int>> likePost(String postId);
 // Future<Either<Failure, List<CommentEntity>>> getComments(String postId);
  //Future<Either<Failure, int>> likeComment(String commentId);
}