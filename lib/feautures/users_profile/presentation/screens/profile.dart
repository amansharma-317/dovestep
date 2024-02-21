import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:startup/config/utils/const.dart';
import 'package:startup/core/providers/user_provider.dart';
import 'package:startup/feautures/chat/presentation/screens/my_chats.dart';
import 'package:startup/feautures/users_profile/presentation/screens/my_posts_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final user = ref.read(userDataProvider);
    String userId;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        body: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(16),
          child: user.when(data: (user){
            userId = user!.userId;
            print(userId);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 16),
                    child: Text("Profile",style: AppTextStyles.font_poppins.copyWith(fontSize: 28, fontWeight: FontWeight.w500),)),
                SizedBox(height: 16,),
                Container(
                  height: height*0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xFF4E8C5F)
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 8),
                          width: width*0.2,
                          //color: Colors.red,
                          child: SvgPicture.string(
                            user.avatar,
                            semanticsLabel: 'Profile Picture',
                            alignment: Alignment.center,
                            //fit: BoxFit.fitHeight,
                            placeholderBuilder: (BuildContext context) => Container(
                              padding: const EdgeInsets.all(30.0),
                              child: const CircularProgressIndicator(),
                            ),
                          ),
                        ),
                        SizedBox(width: 8,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                user.username,
                                style: AppTextStyles.font_poppins.copyWith(fontWeight: FontWeight.w800, color: Color(0xFFFFFFFF), letterSpacing: 1.25),
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                user.phone,
                                style: TextStyle(fontWeight: FontWeight.w300, color: Color(0xFFFFFFFF), fontFamily: GoogleFonts.lato().fontFamily, letterSpacing: 1.25),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 32,),
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(Icons.my_library_books_sharp,color: Color(0xFF4E8C5F)),
                      SizedBox(width: 8,),
                      Text("My Bookings",style: AppTextStyles.font_lato.copyWith(fontSize: 18)),
                      Spacer(),
                      IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios,)),
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyPostsScreen(userId: userId)),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.note_alt_outlined,color: Color(0xFF4E8C5F)),
                      SizedBox(width: 8,),
                      Text("My Posts",style: AppTextStyles.font_lato.copyWith(fontSize: 18)),
                      Spacer(),
                      IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios)),
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(Icons.chat_outlined,color: Color(0xFF4E8C5F)),
                      SizedBox(width: 8,),
                      Text("Chats",style: AppTextStyles.font_lato.copyWith(fontSize: 18)),
                      Spacer(),
                      IconButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyChats()),
                        );
                      }, icon: Icon(Icons.arrow_forward_ios)),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(Icons.notifications_none,color: Color(0xFF4E8C5F)),
                      SizedBox(width: 8,),
                      Text("Notifications",style: AppTextStyles.font_lato.copyWith(fontSize: 18)),
                      Spacer(),
                      IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios)),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                Text("Account",style: AppTextStyles.font_poppins.copyWith(fontSize: 20),),
                SizedBox(height: 16,),
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(Icons.help_outline_outlined,color: Color(0xFF4E8C5F)),
                      SizedBox(width: 8,),
                      Text("Help",style: AppTextStyles.font_lato.copyWith(fontSize: 18)),
                      Spacer(),
                      IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios,)),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                Text("More",style: AppTextStyles.font_poppins.copyWith(fontSize: 20),),
                SizedBox(height: 16,),
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(Icons.help_outline_outlined,color: Color(0xFF4E8C5F)),
                      SizedBox(width: 8,),
                      Text("Privacy Policy",style: AppTextStyles.font_lato.copyWith(fontSize: 18)),
                      Spacer(),
                      IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios)),
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(Icons.help_outline_outlined,color: Color(0xFF4E8C5F)),
                      SizedBox(width: 8,),
                      Text("About Us",style: AppTextStyles.font_lato.copyWith(fontSize: 18)),
                      Spacer(),
                      IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios,)),
                    ],
                  ),
                ),
              ],
            );
          },
              error: (error, stackTrace) => Text("Error fetching data: $error"),
              loading: () => CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
