import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:startup/config/utils/const.dart';
import 'package:startup/feautures/community/domain/entities/post_entity.dart';
import 'package:startup/feautures/community/presentation/providers/community_providers.dart';
import 'package:startup/feautures/community/presentation/screens/comment_screen.dart';
import 'package:startup/feautures/community/presentation/screens/widget/heart.dart';
import 'package:startup/feautures/community/presentation/utilities/timestamp_converter.dart';
import 'package:startup/feautures/users_profile/data/datasources/myPosts_remote_data_source.dart';
import 'package:startup/feautures/users_profile/data/repository/myPosts_repository_impl.dart';
import 'package:startup/feautures/users_profile/presentation/providers/provider_dart.dart';

final firestorePostsRemoteDataSourceProvider = Provider((ref) => FirestorePostsRemoteDataSource(FirebaseFirestore.instance));
final postsRepositoryProvider = Provider((ref) => PostsRepositoryImpl(ref.watch(firestorePostsRemoteDataSourceProvider)));


class MyPostsScreen extends ConsumerWidget {
  final String userId;

  MyPostsScreen({required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsRepository = ref.watch(postsRepositoryProvider);
    final postsFuture = postsRepository.getPostsByUserId(userId);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        body: Builder(
          builder: (BuildContext context) {
            final AsyncValue<List<PostEntity>> postsAsyncValue = ref.watch(postsForUserProvider(userId));
            return postsAsyncValue.when(
              loading: () => CircularProgressIndicator(),
              error: (error, stackTrace) => Text('Error: $error'),
              data: (posts) {
                if(posts.length > 0) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        final String firestoreTimestamp = post.timestamp!;
                        String formattedDateTime = TimestampConverter.formatFirestoreTimestamp(firestoreTimestamp);
                        final commentsCount = ref.watch(commentCountProvider(post.postId!));
                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 104,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: Color(0xFF616060),
                                    width: 2.0,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    post.section!,
                                    style: TextStyle(
                                      fontFamily: GoogleFonts.epilogue().fontFamily,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
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
                                      Text(post.username!, style: AppTextStyles.font_lato.copyWith(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF282827))),
                                      Text(formattedDateTime, style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12, color: Color(0xFF282827), fontFamily: GoogleFonts.lato().fontFamily)),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 8,),
                              Text(post.content!, style: AppTextStyles.font_lato.copyWith(fontSize: 14, color: Color(0xFF000000), height: 1)),
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
                                          onTap: () {
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
                                          commentsCount.when(
                                            data: (count) => count.toString(),
                                            loading: () => 'Loading...',
                                            error: (error, stackTrace) => 'Error: $error',
                                          )
                                      ),
                                      SizedBox(width: 16,),
                                      GestureDetector(
                                        onTap: () async {
                                          await ref.read(deletePostProvider(post.postId!));
                                          ref.refresh(postsForUserProvider(userId));
                                        },
                                        child: Icon(
                                          Icons.delete_outline_rounded,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 24,),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 32),
                    child: Center(
                      child: Text(
                        'You have not made any posts yet.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.font_poppins.copyWith(height: 1.5),
                      ),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
  }

