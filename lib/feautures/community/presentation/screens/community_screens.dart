import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
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
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
             HorizontalScrollButtons(),
              Consumer(
                builder: (context, ref, child) {
                  final postsAsyncValue = ref.watch(communityProvider);
                  return Expanded(
                    child: postsAsyncValue.when(
                      data: (posts) => Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            final post = posts[index];
                            final String firestoreTimestamp = post.timestamp!;
                            final String formattedTimestamp = formatTimestamp(firestoreTimestamp);
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
                                    SizedBox(width: 8,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(post.username!,style: AppTextStyles.font_lato.copyWith(fontSize: 16,fontWeight: FontWeight.w800,color: Color(0xFF282827)),),
                                        Text(formattedTimestamp,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color: Color(0xFF282827),fontFamily: GoogleFonts.lato().fontFamily),),
                                      ],
                                    ),
                                ],
                                ),
                                SizedBox(height: 8,),
                                Text(post.content!,style: AppTextStyles.font_lato.copyWith(fontSize: 14,color: Color(0xFF000000),height: 1),),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Container(
                                        child: HeartButton(post.postId!)),
                                    SizedBox(width: 16,),
                                    Row(
                                      children: [
                                        Container(
                                          height: 36,
                                          width: 36,
                                          child: GestureDetector(
                                            child: Image.asset("assets/images/7b9b8c59-3b1e-4615-8f4c-4d3a07609f97.png"),
                                            onTap: (){
                                              ref.read(postIdProvider.notifier).state = post.postId!;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => CommentScreen(post)),
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 4,),
                                        Text(
                                            commentsCountAsync.when(
                                          data: (count) => count.toString(),
                                          loading: () => 'Loading...',
                                          error: (error, stackTrace) => 'Error: $error',
                                        )
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 24,),
                              ],
                            );
                          },
                        ),
                      ),
                      loading: () => Center(child: CircularProgressIndicator()),
                      error: (error, stackTrace) => Center(child: Text('Error: $error')),
                    ),
                  );
                }
              ),
              /*IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreatePostScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.add),
              ),*/
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePostScreen()),
          );
        },
        child: Container(
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
            color: Color(0xff88AB8E), // Adjust background color as needed
          ),
          //width: 200,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('New Post',style: AppTextStyles.font_poppins.copyWith(fontSize: 16,color: Color(0xFFFFFFFF),height: 1),),
                SizedBox(width: 8),
                Icon(Icons.note_add, color: Colors.white,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
