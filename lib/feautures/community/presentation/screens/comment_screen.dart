import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:startup/config/utils/const.dart';
import 'package:startup/config/utils/format_timestamp.dart';
import 'package:startup/core/providers/user_provider.dart';
import 'package:startup/feautures/community/domain/entities/comment_entity.dart';
import 'package:startup/feautures/community/domain/entities/post_entity.dart';
import 'package:startup/feautures/community/presentation/providers/community_providers.dart';
import 'package:startup/feautures/community/presentation/screens/widget/heart_comment.dart';

import 'widget/heart.dart';

class CommentScreen extends ConsumerStatefulWidget {
  CommentScreen(this.post, {Key? key}) : super(key: key);
  final PostEntity post;

  @override
  ConsumerState<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends ConsumerState<CommentScreen> {
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userDataProvider);
    final stream = ref.watch(commentsProvider);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
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
                    widget.post.section!,
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
                      widget.post.profilePicUrl!,
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
                        widget.post.username!,
                        style: AppTextStyles.font_lato.copyWith(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF282827)),
                      ),
                      Text(
                        formattedDate,
                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12, color: Color(0xFF282827), fontFamily: GoogleFonts.lato().fontFamily),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                widget.post.content!,
                style: AppTextStyles.font_lato.copyWith(fontSize: 14, color: Color(0xFF000000), height: 1),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Container(child: HeartButton(widget.post.postId!)),
                  SizedBox(width: 16),
                  Row(
                    children: [
                      Container(
                        height: 36,
                        width: 36,
                        child: GestureDetector(
                          child: Image.asset("assets/images/7b9b8c59-3b1e-4615-8f4c-4d3a07609f97.png"),
                          onTap: () {
                          },
                        ),
                      ),
                      SizedBox(width: 4),
                      Text('1'),
                    ],
                  ),
                ],
              ),
              Expanded(
                flex: 1,
                child: user.when(
                  data: (user) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        stream.when(
                          data: (comments) {
                            return Expanded(
                              flex: 1,
                              child: ListView.builder(
                                itemCount: comments.length,
                                itemBuilder: (context, index) {
                                  final comment = comments[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 24.0, right: 16, bottom: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Color(0xFFEEEEEE),
                                              child: SvgPicture.string(
                                                comment.userProfileImage!,
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
                                                  comment.username,
                                                  style: AppTextStyles.font_lato.copyWith(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF282827)),
                                                ),
                                                Text(
                                                  formattedDate,
                                                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12, color: Color(0xFF282827), fontFamily: GoogleFonts.lato().fontFamily),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Text(comment.commentContent),
                                        SizedBox(height: 8),
                                        CommentLikeButton(widget.post.postId!, comment.commentId),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          error: (error, stackTrace) => Text(error.toString()),
                          loading: () => CircularProgressIndicator(),
                        ),
                        TextFormField(
                          controller: contentController,
                          decoration: InputDecoration(
                            labelText: 'Enter text',
                            suffixIcon: IconButton(
                              onPressed: () async {
                                ref.read(commentContentProvider.notifier).state = contentController.text;
                                final comment = CommentEntity(
                                  userId: user!.userId,
                                  username: user.username,
                                  commentContent: ref.read(commentContentProvider.notifier).state,
                                  commentTime: formattedDate,
                                  likes: [],
                                  userProfileImage: user.avatar,
                                  commentId: '',
                                );
                                final communityRepository = ref.read(communityRepositoryProvider);
                                await communityRepository.addComment(widget.post.postId!, comment);
                                contentController.clear();
                                print('IconButton pressed');
                              },
                              icon: Icon(Icons.send),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  error: (error, stackTrace) => Text("Error fetching data: $error"),
                  loading: () => Center(child: CircularProgressIndicator()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

