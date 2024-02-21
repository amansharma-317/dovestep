import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:startup/feautures/community/presentation/providers/community_providers.dart';

import '../../../../../core/providers/user_provider.dart';

class HeartButton extends ConsumerStatefulWidget {
  HeartButton(this.postId, {Key? key}) : super(key: key);
  final String postId;


  @override
  ConsumerState<HeartButton> createState() => _HeartButtonState();
}

class _HeartButtonState extends ConsumerState<HeartButton> with TickerProviderStateMixin {
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
    final likeStatus = ref.watch(likePostStatusProvider(widget.postId));
    final likesCountAsync = ref.watch(likePostCountProvider(widget.postId));

    return userData.when(data: (user){
      return likeStatus.when(
        data: (isLiked) {
          return GestureDetector(
            onTap: () async {
              ref.read(currentUserIdProvider.notifier).state = user!.userId;
              ref.read(postIdProvider.notifier).state = widget.postId;
              final result = await ref.read(likePostProvider.future);
              print('button pressed');
              if (result == true) {
                ref.refresh(likePostCountProvider(widget.postId));
                ref.refresh(likePostStatusProvider(widget.postId));

                _controller
                  ..reset()
                  ..forward();
                // Update UI or perform additional actions if needed
                print('Post liked!');
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
