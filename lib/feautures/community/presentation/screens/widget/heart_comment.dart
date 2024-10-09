import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:startup/core/providers/user_provider.dart';
import 'package:startup/feautures/community/presentation/providers/community_providers.dart';

class CommentLikeButton extends ConsumerStatefulWidget {
  const CommentLikeButton(this.postId, this.commentId, {Key? key}) : super(key: key);
  final String postId;
  final String commentId;

  @override
  ConsumerState<CommentLikeButton> createState() => _CommentLikeButtonState();
}

class _CommentLikeButtonState extends ConsumerState<CommentLikeButton> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataProvider);
    final postId = widget.postId;
    final commentId = widget.commentId;
    final likeStatus = ref.watch(likeCommentStatusProvider(CommentIdAndPostIdParams(postId: postId, commentId: commentId)));
    final likesCountAsync = ref.watch(likeCommentCountProvider(CommentIdAndPostIdParams(postId: postId, commentId: commentId)));


    return userData.when(data: (user){
      return likeStatus.when(
        data: (isLiked) {
          return GestureDetector(
            onTap: () async {
              ref.read(currentUserIdProvider.notifier).state = user!.userId;
              ref.read(postIdProvider.notifier).state = widget.postId;
              ref.read(commentIdProvider.notifier).state = widget.commentId;
              final result = await ref.read(likeCommentProvider.future);
              print('button pressed');
              if (result == true) {
                ref.refresh(likeCommentCountProvider(CommentIdAndPostIdParams(postId: postId, commentId: commentId)));
                ref.refresh(likeCommentStatusProvider(CommentIdAndPostIdParams(postId: postId, commentId: commentId)));

                _controller
                  ..reset()
                  ..forward();
                // Update UI or perform additional actions if needed
                print('Comment liked!');
              } else if (result == false ){
                // Handle the case where the liking operation failed
                print('false result came back');
              } else {
                print('result false in heart.dart');
              }
            },
            child: Row(
              children: [
                ScaleTransition(
                  scale: Tween(begin: 0.95, end: 1.0).animate(
                    CurvedAnimation(parent: _controller, curve: Curves.easeOut),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.grey,
                        size: 36,
                      ),
                      SizedBox(width: 4),
                      Text(likesCountAsync.when(
                        data: (count) => count.toString(),
                        loading: () => 'Loading...', // You can display a loading indicator or any other message
                        error: (error, stackTrace) => 'Error: $error', // Display an error message if fetching the count fails
                      )),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => CircularProgressIndicator(),
        error: (error, stackTrace) => Text("Error checking like status: $error"),
      );
    },  error: (error, stackTrace) => Text("Error filling heart: $error"), loading: () => Center(child: CircularProgressIndicator()));
  }
}
