import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/community_remote_data_source.dart';
import '../../data/repositories/community_repository_impl.dart';
import '../../domain/entities/comment_entity.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/community_repository.dart';

final communityRepositoryProvider = Provider<CommunityRepository>((ref) {
  return CommunityRepositoryImpl(remoteDataSource: CommunityRemoteDataSource());
});

//providers related with getting posts for each section
final communityProvider = FutureProvider<List<PostEntity>>((ref) async {
  try {
    final repository = ref.watch(communityRepositoryProvider);
    final sectionToPost = ref.watch(selectedCommunitySectionProvider.notifier).state;
    return await repository.getPostsBySection(sectionToPost);
  } catch (e) {
    // Handle or log the error
    print('Error in provider: $e');
    return [];
  }
});

final selectedCommunitySectionProvider = StateProvider<String>((ref) => 'All');


final addPostSelectedSectionProvider = StateProvider<String>((ref) => 'All');

final contentProvider = StateProvider<String>((ref) => '');

final commentContentProvider = StateProvider<String>((ref) => '');

final likePostProvider = FutureProvider.autoDispose<bool>(
      (ref) async {
    try {
      final repository = ref.watch(communityRepositoryProvider);
      final postId = ref.watch(postIdProvider);
      print(postId);
      final currentUserId = ref.read(currentUserIdProvider);
      print(currentUserId);
      await repository.likePost(postId, currentUserId);
      return true;
    } catch (e) {
      // Handle or log the error
      print('Error in likePostProvider: $e');
      return false;
    }
  },
);

final likeCommentProvider = FutureProvider.autoDispose<bool>(
      (ref) async {
    try {
      final repository = ref.watch(communityRepositoryProvider);
      final commentId = ref.watch(commentIdProvider);
      final postId = ref.watch(postIdProvider);
      print(commentId);
      final currentUserId = ref.read(currentUserIdProvider);
      print(currentUserId);
      await repository.likeComment(commentId,postId, currentUserId);
      return true;
    } catch (e) {
      // Handle or log the error
      print('Error in likePostProvider: $e');
      return false;
    }
  },
);


// Provider for the postId
final postIdProvider = StateProvider<String>((ref) => '');

final commentIdProvider = StateProvider<String>((ref) => '');

// Provider for the currentUserId
final currentUserIdProvider = StateProvider<String>((ref) => '');

final commentsProvider = StreamProvider.autoDispose<List<CommentEntity>>((ref) async* {
  final postId = ref.watch(postIdProvider);
  final repository = ref.read(communityRepositoryProvider);
  yield* repository.streamCommentsForPost(postId);
});

final likePostStatusProvider = FutureProvider.autoDispose.family<bool, String>((ref, postId) async {
  final repository = ref.watch(communityRepositoryProvider);
  return await repository.checkLikeStatusForPost(postId);
});

final likeCommentStatusProvider = FutureProvider.autoDispose.family<bool, CommentLikeParams>(
      (ref, params) async {
    final repository = ref.watch(communityRepositoryProvider);
    print("status");
    return await repository.checkLikeStatusForComment(params.commentId, params.postId);
  },
);

final likePostCountProvider = FutureProvider.autoDispose.family<int, String>((ref, postId) async {
final repository = ref.watch(communityRepositoryProvider);
return await repository.getLikeCountForPost(postId);
});


final likeCommentCountProvider = FutureProvider.autoDispose.family<int, CommentLikeParams>(
      (ref, params) async {
    final repository = ref.watch(communityRepositoryProvider);
    print('likesCommentCount');
    return await repository.getLikeCountForComment(params.commentId, params.postId);
  },
);


final commentCountProvider = FutureProvider.autoDispose.family<int, String>((ref, postId) async {
  final repository = ref.watch(communityRepositoryProvider);
  return await repository.getCommentsCount(postId);
});

class CommentLikeParams {
  final String postId;
  final String commentId;

  CommentLikeParams({required this.postId, required this.commentId});
}