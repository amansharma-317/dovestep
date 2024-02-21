  import 'package:flutter/material.dart';
  import 'package:flutter_riverpod/flutter_riverpod.dart';
  import 'package:fluttertoast/fluttertoast.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'package:startup/config/utils/const.dart';
  import 'package:startup/feautures/community/domain/entities/post_entity.dart';
  import '../../../../core/providers/user_provider.dart';
  import '../providers/community_providers.dart';
  import 'package:intl/intl.dart';
  class CreatePostScreen extends ConsumerWidget {
    @override
    Widget build(BuildContext context, WidgetRef ref) {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
      final TextEditingController contentController = TextEditingController(); // Controller for the TextFormField
      final user = ref.watch(userDataProvider);
      return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFFEEEEEE),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Material(
                elevation: 1,
                child: Container(
                  margin: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close,color: Colors.black,size: 25,)),
                      SizedBox(width: 8,),
                      Text('Create Post',style: AppTextStyles.font_poppins.copyWith(fontWeight: FontWeight.w700,fontSize: 18),),
                      Spacer(),
                      user.when(
                          data: (user){
                            return GestureDetector(
                                onTap: () async{
                                  if(contentController.text.trim().isNotEmpty && contentController.text.length > 8){

                                    ref.read(contentProvider.notifier).state = contentController.text;

                                    final post = PostEntity(
                                      userId: user!.userId,
                                      username: user.username,
                                      content: ref.read(contentProvider.notifier).state,
                                      timestamp: formattedDate,
                                      likes: [],
                                      //comments: [],
                                      postId: "",
                                      profilePicUrl: user.avatar,
                                      section: ref.read(addPostSelectedSectionProvider.notifier).state,
                                    );

                                    final communityRepository = ref.read(communityRepositoryProvider);
                                    await communityRepository.addPost(post);
                                    ref.refresh(communityProvider);
                                    Navigator.pop(context);
                                  }
                                  else{
                                    Fluttertoast.showToast(
                                      msg: "Post content cannot be empty",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  }
                                },
                                child: Text('Post',style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily, fontWeight: FontWeight.w700,fontSize: 20,color: Color(0xff27405A)),));
                          },
                        error: (error, stackTrace) => Text("Error fetching data: $error"),
                        loading: () => Center(child: CircularProgressIndicator()),

                      )],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Consumer(
                  builder: (context, watch, child) {
                    //ref.read(fifthQuestionAnswerProvider.notifier).state = 4
                    final selectedSection = ref.read(addPostSelectedSectionProvider.notifier).state;
                    return Column(
                      children: [
                        SizedBox(height: 8,),
                        Container(
                          width: width * 0.4,
                          margin: EdgeInsets.only(right: 32, top: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: DropdownButtonFormField<String>(
                            icon: Icon(Icons.unfold_more),
                            isExpanded: true,
                            value: selectedSection,
                            onChanged: (value) {
                              ref.read(addPostSelectedSectionProvider.notifier).state = value!;
                            },
                            items: ['All',
                              'Anxiety',
                              'Depression',
                              'Stress',
                              'Relationships',
                              'Trauma',
                              'Addiction',
                              'Self-esteem',
                              'Loneliness',]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.black,width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.red,width: 1),
                              ),
                            ),
                          ),
                        ),

                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: contentController,
                        maxLines: null, // Allow unlimited lines for writing content
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          hintText: 'Write down your thoughts...', // Use hintText instead of labelText
                          hintStyle: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 20), // Adjust hint text color if needed
                          border: InputBorder.none, // Remove the bottom line
                        ),
                        textAlignVertical: TextAlignVertical.bottom,
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
