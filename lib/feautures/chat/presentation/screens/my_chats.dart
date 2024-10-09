import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:startup/config/utils/const.dart';
import 'package:startup/config/utils/format_timestamp.dart';
import 'package:startup/config/utils/get_other_userid_from_chatid.dart';
import 'package:startup/core/providers/user_provider.dart';
import 'package:startup/feautures/chat/presentation/providers/chat_provider.dart';
import 'package:startup/feautures/chat/presentation/providers/refresh_provider.dart';
import 'package:startup/feautures/chat/presentation/screens/chat_screen.dart';

class MyChats extends ConsumerWidget {
  MyChats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final userProfileFuture = ref.watch(userDataProvider);
    final chatsAsyncValue = ref.watch(chatsProvider);

    return PopScope(
      canPop: true,
      onPopInvoked: (_) {
        print('popped');
        ref.refresh(chatsProvider);
        print('refreshed');
      },
      child: Scaffold(
        backgroundColor: Color(0xffFF5F5F5),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //header
                    Container(
                      child: Text('Chats', style: AppTextStyles.font_poppins.copyWith(fontWeight: FontWeight.w600, letterSpacing: 1.25, fontSize: 24),),
                    ),

                    SizedBox(height: 16,),

                    //Chats
                    userProfileFuture.when(
                      data: (user) {
                        return chatsAsyncValue.when(
                          data: (chats) {
                            print('total chats for this user is ' + chats.length.toString());
                            if (chats.length > 0) {
                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: chats.length, // Replace with the actual number of items in your list
                                itemBuilder: (BuildContext context, int index) {
                                  final chat = chats[index];
                                  String chatId = chat.chatId;
                                  String currentUserId = user!.userId;
                                  String otherUserId = getOtherUserId(chatId, currentUserId);

                                  final otherUserProfileFuture = ref.watch(otherUserDataProvider(otherUserId));

                                  return otherUserProfileFuture.when(
                                    data: (otherUser) {
                                      bool isLastMessageByCurrentUser = false;
                                      bool isLastMessageRead = false;
                                      String formattedTimestamp = '';

                                      if (chat.lastMessage != null) {
                                        if ((otherUser!.userId) ==
                                            chat.lastMessage?.senderID) {
                                          isLastMessageByCurrentUser = false;
                                        } else {
                                          isLastMessageByCurrentUser = true;
                                        }

                                        if (isLastMessageByCurrentUser !=
                                            true) {
                                          isLastMessageRead =
                                              chat.lastMessage!.isRead;
                                        }
                                        final DateTime dateTime = DateTime.parse(chat.lastMessage!.timestamp.toString());
                                        formattedTimestamp = timeAgo(dateTime);
                                      }

                                      if(otherUser != null) {
                                        return Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => ChatScreen(chatId: chat.chatId), // Pass the chatId to the ChatScreen
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xff88AB8E).withOpacity(0.5),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                height: height * 0.15,
                                                margin: EdgeInsets.symmetric(horizontal: 0),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: 16,),
                                                    CircleAvatar(
                                                      backgroundColor: Color(0xFFEEEEEE),
                                                      child: SvgPicture.string(
                                                        otherUser.avatar,
                                                        semanticsLabel: 'Profile Picture',
                                                        placeholderBuilder: (BuildContext context) => Container(
                                                          padding: const EdgeInsets.all(20.0),
                                                          child: Center(child: Center(child: const CircularProgressIndicator())),
                                                        ),
                                                      ),
                                                      radius: height*0.04,
                                                    ),
                                                    SizedBox(width: 10,),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            otherUser.username,
                                                            style: GoogleFonts.poppins(
                                                              textStyle: TextStyle(
                                                                color: Colors.black,
                                                                letterSpacing: 1,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                          ),
                                                          // Full name or message
                                                          Flexible(
                                                            child: Container(
                                                              width: width * 0.6,
                                                              child:
                                                              Text(
                                                                (isLastMessageByCurrentUser ? 'You: ' : '') +
                                                                    (chat.lastMessage != null ? chat.lastMessage!.text : 'Start chatting!'),
                                                                style: TextStyle(
                                                                  color: Colors.black,
                                                                  letterSpacing: 1,
                                                                  fontSize: 14,
                                                                  fontWeight: isLastMessageByCurrentUser || isLastMessageRead ? FontWeight.normal : FontWeight.bold,
                                                                  overflow: TextOverflow.ellipsis,
                                                                ),
                                                              ),

                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Column(
                                                        children: [
                                                          Spacer(),
                                                          !isLastMessageRead ? Container() : Icon(Icons.circle, size: height * 0.01, color: Color(0xff008080)),

                                                          //Icon(Icons.circle, size: height * 0.01, color: Color(0xff008080),),
                                                          SizedBox(height: 12,),
                                                          GestureDetector(
                                                            onTap: () async {
                                                              // Handle onTap action for the time
                                                            },
                                                            child: formattedTimestamp.length>0 ? FittedBox(
                                                              fit: BoxFit.contain,
                                                              child: Text(
                                                                formattedTimestamp,
                                                                style: GoogleFonts.lato(
                                                                  textStyle: TextStyle(
                                                                    color: Colors.black54,
                                                                    letterSpacing: 1,
                                                                    //fontSize: 10,
                                                                    fontWeight: FontWeight.normal,
                                                                  ),
                                                                ),
                                                              ),
                                                            ) : Container(),
                                                          ),
                                                          Spacer(),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 12,),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                          ],
                                        );
                                      } else{
                                        print('other user not found');
                                      }
                                    },
                                    loading: () => Center(child: CircularProgressIndicator()),
                                    error: (error, stackTrace) => Text('Error fetching chats: $error'),
                                  );

                                },
                              );
                            } else {
                              print('no chats yet');
                              return Center(
                                child: Text(
                                  'You don\'t have any chats yet.',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.font_poppins.copyWith(height: 1.5),
                                ),
                              );
                            }
                          },
                          loading: () => Center(child: CircularProgressIndicator()),
                          error: (error, stackTrace) => Text('Error fetching chats: $error'),
                        );
                      },
                      error: (error, stackTrace) => Text("Error fetching data: $error"),
                      loading: () => Center(child: CircularProgressIndicator()),
                    ),
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }
}