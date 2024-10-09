import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:startup/config/utils/const.dart';
import 'package:startup/config/utils/format_timestamp.dart';
import 'package:startup/feautures/community/presentation/providers/community_providers.dart';
import 'package:startup/feautures/community/presentation/screens/create_post_screen.dart';
import 'package:startup/feautures/community/presentation/screens/widget/options_button.dart';
import 'package:startup/feautures/community/presentation/utilities/timestamp_converter.dart';
import 'comment_screen.dart';
import 'widget/heart.dart';

class CommunityScreen extends ConsumerWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSection = ref.watch(selectedCommunitySectionProvider);
    final postState = ref.watch(communityProvider(selectedSection));
    final scrollController = ref.watch(scrollControllerProvider);

    final shouldRefresh = ref.watch(shouldRefreshProvider);

    ref.listen<bool>(shouldRefreshProvider, (previous, next) {
      if (next) {
        ref.read(communityProvider(selectedSection).notifier).clearPosts(); // Clear posts
        ref.read(communityProvider(selectedSection).notifier).fetchPosts(); // Fetch new posts
        ref.read(shouldRefreshProvider.notifier).state = false; // Reset the flag
      }
    });

    bool hasFetchedInitialPosts = ref.watch(initialFetchFlagProvider);

    // Trigger fetching posts if not already in progress and initial fetch hasn't occurred
    if (postState.posts.isEmpty && !postState.isLoadingMore && !hasFetchedInitialPosts) {
      print('running');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        print('fetchPosts being run inside build of screen');
        ref.read(communityProvider(selectedSection).notifier).fetchPosts();
        ref.read(initialFetchFlagProvider.notifier).state = true; // Set flag to true
      });
    }

    // Listener for scroll events to trigger loading more posts
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200 && !postState.isLoadingMore) {
        print('Loading more posts...');
        ref.read(communityProvider(selectedSection).notifier).fetchPosts(isLoadingMore: true);
      }
    });

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              HorizontalScrollButtons(),
              SizedBox(height: height*0.01,),
              Expanded(
                child: postState.posts.isEmpty && !postState.isLoadingMore
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                  controller: scrollController,
                  itemCount: postState.posts.length + (postState.isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    print('number of posts in ui is ' + (postState.posts.length + (postState.isLoadingMore ? 1 : 0)).toString());
                    if (index < postState.posts.length) {
                      final post = postState.posts[index];
                      final formattedTimestamp = formatTimestamp(post.timestamp!);
                      final commentsCountAsync = ref.watch(commentCountProvider(post.postId!));

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Color(0xFFEEEEEE),
                                child: SvgPicture.string(
                                  post.profilePicUrl!,
                                  semanticsLabel: 'Profile Picture',
                                  placeholderBuilder: (BuildContext context) => Container(
                                    padding: const EdgeInsets.all(30.0),
                                    child: const CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post.username!,
                                    style: AppTextStyles.font_lato.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF282827),
                                    ),
                                  ),
                                  Text(
                                    formattedTimestamp,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                      color: Color(0xFF282827),
                                      fontFamily: GoogleFonts.lato().fontFamily,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              ref.read(postIdProvider.notifier).state = post.postId!;
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CommentScreen(post)),
                              );
                            },
                            child: Text(
                              post.content!,
                              style: AppTextStyles.font_lato.copyWith(
                                fontSize: 14,
                                color: Color(0xFF000000),
                                height: 1,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              HeartButton(post.postId!),
                              SizedBox(width: 16),
                              Row(
                                children: [
                                  Container(
                                    height: 36,
                                    width: 36,
                                    child: GestureDetector(
                                      child: Image.asset("assets/images/7b9b8c59-3b1e-4615-8f4c-4d3a07609f97.png"),
                                      onTap: () {
                                        ref.read(postIdProvider.notifier).state = post.postId!;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => CommentScreen(post)),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    commentsCountAsync.when(
                                      data: (count) => count.toString(),
                                      loading: () => 'Loading...',
                                      error: (error, stackTrace) => 'Error: $error',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                        ],
                      );
                    } else {
                      // Show loading indicator at the end of the list
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          ref.read(shouldRefreshProvider.notifier).state = true;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePostScreen()),
          );
        },
        child: Container(
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xff88AB8E),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'New Post',
                  style: AppTextStyles.font_poppins.copyWith(
                    fontSize: 16,
                    color: Color(0xFFFFFFFF),
                    height: 1,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.note_add, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
