import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:startup/config/utils/format_timestamp.dart';
import 'package:startup/config/utils/get_other_userid_from_chatid.dart';
import 'package:startup/core/providers/user_provider.dart';
import 'package:startup/feautures/chat/domain/entities/message_entity.dart';
import 'package:startup/feautures/chat/domain/entities/send_message_params.dart';
import 'package:startup/feautures/chat/domain/params/pagination_params.dart';
import 'package:startup/feautures/chat/presentation/providers/chat_provider.dart';

class ChatScreen extends ConsumerWidget {
  ChatScreen({Key? key, required this.chatId}) : super(key: key);
  final String chatId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController messageController = TextEditingController();
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    final otherUserId = getOtherUserId(chatId, currentUserId);
    final otherUserProfileFuture = ref.watch(otherUserDataProvider(otherUserId));

    Color msgBgColor = Color(0xffe8e8e8);

    final scrollController = ScrollController();

    void _loadMoreData() {
      ref.read(pageNumberProvider.notifier).state++;
      ref.refresh(messagesProvider(chatId));
    }

    scrollController.addListener(() {
      print('scrolling');
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        print('scrolled to max');
        // End of the list reached, load more messages
      }
    });

    return PopScope(
      canPop: true,
      onPopInvoked: (_) {
        ref.refresh(chatsProvider);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            flexibleSpace: SafeArea(
              child: otherUserProfileFuture.when(
                  data: (otherUser) {
                    return Container(

                      padding: EdgeInsets.only(right: 16),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
                          ),
                          SizedBox(width: 2),
                          CircleAvatar(
                            backgroundColor: Color(0xFFEEEEEE),
                            child: SvgPicture.string(
                              otherUser!.avatar,
                              semanticsLabel: 'Profile Picture',
                              placeholderBuilder: (BuildContext context) => Container(
                                padding: const EdgeInsets.all(4.0),
                                child: const CircularProgressIndicator(),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                    otherUser.username,
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(color: Colors.black,
                                          letterSpacing: 1,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                    },
                  loading: () => CircularProgressIndicator(),
                  error: (error, stackTrace) => Text('Error fetching chats: $error'),
              )
            ),
          ),

          body: Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  //padding: EdgeInsets.all(16),
                  child: Consumer(
                    builder: (context, watch, child) {
                      final currentUserId = FirebaseAuth.instance.currentUser!.uid;

                      final messagesAsyncValue = ref.watch(messagesProvider(chatId));

                      return messagesAsyncValue.when(
                          data: (messages) {
                            if(messages.length == 0) {
                              print('no msg');
                              return Container();
                            }

                            return ListView.builder(
                              controller: scrollController,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: messages.length,
                              reverse: true,
                              itemBuilder: (BuildContext context, int index) {
                                final message = messages[index];
                                final isCurrentUser = message.senderID == currentUserId;

                                final firestoreTimestamp = message.timestamp;
                                final formattedTimestamp = formatTimestampForChatScreen(firestoreTimestamp);
                                return Container(
                                  padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                                  child: Align(
                                    alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: isCurrentUser ? msgBgColor : Color(0xff88AB8E).withOpacity(0.3), // Use a consistent color for messages
                                      ),
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            message.text, // Replace with actual message content
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                color: Colors.black,
                                                letterSpacing: 1,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            formattedTimestamp, // Replace with message timestamp
                                            style: TextStyle(fontSize: 8),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          error: (error, stackTrace) => Center(child: Text('Error: $error')),
                          loading: () => Center(child: CircularProgressIndicator()),
                      );
                    }
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Color(0xff008080),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(Icons.add, color: Colors.white, size: 20, ),
                        ),
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                              hintText: "Write message...",
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none
                          ),
                        ),
                      ),
                      SizedBox(width: 15,),
                      FloatingActionButton(
                        onPressed: () async {
                          //ref.refresh(messagesProvider(chatId));
                          print('send message button pressed');
                          final text = messageController.text.trim();
                          if (text.isNotEmpty) {
                            //split the chatId
                            final userIds = chatId.split('-');

                            if (userIds.length == 2) {
                              final userIds = chatId.split('-');
                              final user1Id = userIds[0];
                              final user2Id = userIds[1];

                              // Get current user ID from Firebase Auth
                              final currentUserId = FirebaseAuth.instance.currentUser!.uid;

                              // Determine senderID and receiverID based on current user
                              String senderID = '';
                              String receiverID = '';
                              if (currentUserId != null) {
                                if (currentUserId == user1Id) {
                                  senderID = user1Id;
                                  receiverID = user2Id;
                                } else if (currentUserId == user2Id) {
                                  senderID = user2Id;
                                  receiverID = user1Id;
                                }
                              }
                              final message = Message(
                                id: '',
                                text: text,
                                senderID: senderID, // Replace with actual sender ID
                                receiverID: receiverID, // Replace with actual receiver ID
                                timestamp: DateTime.now(),
                                isRead: false,
                              );
                              try {
                                ref.read(sendMessageProvider(SendMessageParams(message, chatId)));
                                messageController.clear();
                              } catch (e) {
                                print('Error sending message: $e');
                                // Handle error sending message
                              }
                            } else {
                              print('Invalid chatId format');
                            }
                          } else {
                            print('empty text in message to be sent');
                          }
                        },
                        child: Icon(Icons.send,color: Colors.white,size: 18,),
                        backgroundColor: Color(0xff008080),
                        elevation: 0,
                      ),
                    ],

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
