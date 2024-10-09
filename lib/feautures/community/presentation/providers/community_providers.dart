import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import '../../data/datasources/community_remote_data_source.dart';
import '../../data/repositories/community_repository_impl.dart';
import '../../domain/entities/comment_entity.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/community_repository.dart';

// Repository Provider
import 'package:riverpod/riverpod.dart';

// ... other imports ...

// Provider for the repository
final communityRepositoryProvider = Provider<CommunityRepository>((ref) {
  return CommunityRepositoryImpl(remoteDataSource: CommunityRemoteDataSource());
});

// State class to manage pagination
class PostPaginationState {
  final List<PostEntity> posts;
  final DocumentSnapshot? lastDocument; // Track the last document for pagination
  final bool isLoadingMore;

  PostPaginationState({
    required this.posts,
    this.lastDocument,
    this.isLoadingMore = false,
  });
}


// StateNotifierProvider for managing the state and business logic
final communityProvider = StateNotifierProvider.family<PostsNotifier, PostPaginationState, String>(
      (ref, section) {
        print('cp called');
    final communityRepository = ref.read(communityRepositoryProvider);
    return PostsNotifier(communityRepository, section);
  },
);

// The StateNotifier that manages the posts state
class PostsNotifier extends StateNotifier<PostPaginationState> {
  final CommunityRepository _communityRepository;
  final String _section;

  PostsNotifier(this._communityRepository, this._section)
      : super(PostPaginationState(posts: [], lastDocument: null));

  // Method to clear posts
  void clearPosts() {
    state = PostPaginationState(posts: [], lastDocument: null, isLoadingMore: false);
  }

  Future<void> fetchPosts({bool isLoadingMore = false}) async {
    print(state.isLoadingMore);
    print('inside fetchposts before if');
    if (isLoadingMore && state.isLoadingMore) return;
    print('inside fetchposts after if');
    // Set loading state
    state = PostPaginationState(
      posts: state.posts,
      lastDocument: state.lastDocument,
      isLoadingMore: isLoadingMore,
    );

    // Fetch posts
    final querySnapshots = await _communityRepository.getPostsBySection(
      _section,
      isLoadingMore ? state.lastDocument : null, // Use lastDocument only when loading more
    );

    if (querySnapshots.isNotEmpty) {
      print('qs not empty');
      final newPosts = querySnapshots.map((doc) => PostEntity.fromMap(doc.data() as Map<String, dynamic>)).toList();
      final newLastDocument = querySnapshots.last;

      // Update state with new posts and last document
      state = PostPaginationState(
        posts: [...state.posts, ...newPosts],
        lastDocument: newLastDocument,
        isLoadingMore: false,
      );
    } else {
      // No more posts to load
      state = PostPaginationState(
        posts: state.posts,
        lastDocument: state.lastDocument,
        isLoadingMore: false,
      );
    }
  }

}

final initialFetchFlagProvider = StateProvider<bool>((ref) => false);

///////////
final shouldRefreshProvider = StateProvider<bool>((ref) => false);



final scrollControllerProvider = Provider<ScrollController>((ref) {
  final controller = ScrollController();

  // Fetch initial posts when the controller is attached
  controller.addListener(() {
    final scrollOffset = controller.offset;
    final maxScrollExtent = controller.position.maxScrollExtent;

    if (scrollOffset >= maxScrollExtent - 200) {
      // Trigger loading more posts when near the bottom
      ref.read(communityProvider('your_section').notifier).fetchPosts(isLoadingMore: true);
    }
  });

  return controller;
});



// Providers for various state management
final selectedCommunitySectionProvider = StateProvider<String>((ref) => 'All');
final addPostSelectedSectionProvider = StateProvider<String>((ref) => 'All');
final contentProvider = StateProvider<String>((ref) => '');
final commentContentProvider = StateProvider<String>((ref) => '');
final postIdProvider = StateProvider<String>((ref) => '');
final commentIdProvider = StateProvider<String>((ref) => '');
final currentUserIdProvider = StateProvider<String>((ref) => '');
final postContentProvider = StateProvider<String>((ref) => '');

// Providers for liking posts and comments
final likePostProvider = FutureProvider.autoDispose<bool>((ref) async {
  try {
    final repository = ref.watch(communityRepositoryProvider);
    final postId = ref.watch(postIdProvider);
    final currentUserId = ref.read(currentUserIdProvider);
    await repository.likePost(postId, currentUserId);
    return true;
  } catch (e) {
    print('Error in likePostProvider: $e');
    return false;
  }
});

final likeCommentProvider = FutureProvider.autoDispose<bool>((ref) async {
  try {
    final repository = ref.watch(communityRepositoryProvider);
    final commentId = ref.watch(commentIdProvider);
    final postId = ref.watch(postIdProvider);
    final currentUserId = ref.read(currentUserIdProvider);
    await repository.likeComment(commentId, postId, currentUserId);
    return true;
  } catch (e) {
    print('Error in likeCommentProvider: $e');
    return false;
  }
});

// Providers for comment count and like status
final commentCountProvider = FutureProvider.autoDispose.family<int, String>((ref, postId) async {
  final repository = ref.watch(communityRepositoryProvider);
  return await repository.getCommentsCount(postId);
});

final likePostStatusProvider = FutureProvider.autoDispose.family<bool, String>((ref, postId) async {
  final repository = ref.watch(communityRepositoryProvider);
  return await repository.checkLikeStatusForPost(postId);
});

final likePostCountProvider = FutureProvider.autoDispose.family<int, String>((ref, postId) async {
  final repository = ref.watch(communityRepositoryProvider);
  return await repository.getLikeCountForPost(postId);
});

final likeCommentStatusProvider = FutureProvider.autoDispose.family<bool, CommentIdAndPostIdParams>(
      (ref, params) async {
    final repository = ref.watch(communityRepositoryProvider);
    return await repository.checkLikeStatusForComment(params.commentId, params.postId);
  },
);

final likeCommentCountProvider = FutureProvider.autoDispose.family<int, CommentIdAndPostIdParams>(
      (ref, params) async {
    final repository = ref.watch(communityRepositoryProvider);
    return await repository.getLikeCountForComment(params.commentId, params.postId);
  },
);

// Provider for streaming comments
final commentsProvider = StreamProvider.autoDispose<List<CommentEntity>>((ref) async* {
  final postId = ref.watch(postIdProvider);
  final repository = ref.read(communityRepositoryProvider);
  yield* repository.streamCommentsForPost(postId);
});

// Provider for deleting posts
final deletePostProvider = FutureProvider.autoDispose.family<void, String>((ref, postId) async {
  final repository = ref.watch(communityRepositoryProvider);
  return await repository.deletePost(postId);
});

// Helper class for comment and post ID params
class CommentIdAndPostIdParams extends Equatable {
  final String postId;
  final String commentId;

  CommentIdAndPostIdParams({required this.postId, required this.commentId});

  @override
  List<Object?> get props => [postId, commentId];
}
