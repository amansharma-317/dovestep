import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:startup/config/utils/const.dart';
import 'package:startup/core/models/user_model.dart';
import 'package:startup/core/providers/user_provider.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // AsyncValue<UserProfile> userProfile = ref.watch(userDataProvider);
    final userProfileFuture = ref.watch(userDataProvider);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: height*0.52,
                    child: Stack(
                      children: [
                        Container(
                          height: height*0.35*0.6,
                          decoration: BoxDecoration(
                              color: Color(0x5088AB8E),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                              )
                          ),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(backgroundImage: AssetImage("assets/images/profileicon.png"),radius: 16,),
                                  Spacer(),
                                  CircleAvatar(backgroundImage: AssetImage("assets/images/img.png"),radius: 16,),
                                ],
                              ),
                              SizedBox(height: 16,),
                              userProfileFuture.when(
                                data: (user) {
                                  // Print the user data to the console
                                  print("Fetched user data: $user");

                                  // Return a multiline Text widget
                                  return Column(
                                    children: [
                                      Text("Good morning,"),
                                      Text(user!.username, style: AppTextStyles.font_poppins),
                                    ],
                                  );
                                },
                                  error: (error, stackTrace) => Text("Error fetching data: $error"),
                                  loading: () => Center(child: CircularProgressIndicator()),
                              )
                              // Text("username",style: AppTextStyles.font_poppins,),
                            ],
                          ),
                        ),
                        //SizedBox(height: 16,),
                        Positioned(
                            top: height*0.25*0.6,
                            //height: 288,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 16 ),
                              width: width-32,
                              height: height*0.36,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Color(0xFF88AB8E),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  Text("Support is a tap away!",style: AppTextStyles.font_poppins.copyWith(fontSize: width*0.06,color: Color(0xFFF5F5F5),fontWeight: FontWeight.bold,letterSpacing: 2),),
                                  SizedBox(height: 16,),
                                  Row(
                                    children: [
                                      Column(children: [
                                        Container(
                                          height: height*0.15,
                                          child: Image.asset("assets/images/wheel.png",fit: BoxFit.fill,),
                                        ),
                                        SizedBox(height: 16,),
                                        Text("Reach Out, Speak Up",style: AppTextStyles.font_lato.copyWith(fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xffFFFFFF)),),
                                        SizedBox(height: 8,),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(0xFF27405A),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                              fixedSize: Size(width*0.4, height*0.05),
                                              elevation: 0,
                                            ),
                                            onPressed: (){}, child: Text("Chat Now",style: AppTextStyles.font_poppins.copyWith(fontSize: height*0.017,fontWeight: FontWeight.w700,color: Color(0xFFFBFBFB),letterSpacing: 1),)),

                                      ],),
                                      Spacer(),
                                      // SizedBox(width: 8,),
                                      Column(
                                        children: [
                                          Container(
                                            height: height*0.15,
                                            width: 132 ,
                                            child: Image.asset("assets/images/f2f4cd11-27b4-4a8c-b9a5-8de20eb358af.png",fit: BoxFit.fill,),
                                          ),
                                          SizedBox(height: 16,),
                                          Text("Emergency Help",style: AppTextStyles.font_lato.copyWith(fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xffFFFFFF)),),
                                          SizedBox(height: 8,),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(0xFFC60404),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                fixedSize: Size(width*0.4, height*0.05),
                                                elevation: 0,
                                              ),
                                              onPressed: (){}, child: Text("Instant Help",style: AppTextStyles.font_poppins.copyWith(fontSize: height*0.017,fontWeight: FontWeight.w700,color: Color(0xFFFBFBFB),letterSpacing: 1),)),
                                        ],
                                      ),
                                    ],),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    height: height*0.225,
                    margin: EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(0x3088AB8E),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Container(
                            padding: EdgeInsets.only(top:24,bottom: 16,left: 16,right: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("1 on 1 Sessions",style: AppTextStyles.font_poppins.copyWith(fontSize: 24,fontWeight: FontWeight.w600,color: Color(0xFF393938)),),
                                SizedBox(height: 16,),
                                Text("Let's open up to the things that",style: AppTextStyles.font_poppins.copyWith(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xFF393938)),),
                                SizedBox(height: 8,),
                                Text("matter the most",style: AppTextStyles.font_poppins.copyWith(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xFF393938)),),
                                SizedBox(height: 24,),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){}, child:Text("Book Now",style: AppTextStyles.font_poppins.copyWith(fontSize: 18,fontWeight: FontWeight.bold,letterSpacing: 1,color: Color(0xFF27405A)),), ),
                                    SizedBox(width: 8,),
                                    Container(
                                        height: 14,
                                        width: 14,
                                        child: Image.asset("assets/images/af3984a0-4f50-45c0-b655-7c79aff67ab9.png",fit: BoxFit.fill,)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 16,),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Container(
                                  //height: 168,
                                  padding: EdgeInsets.only(top: 24,bottom: 16,right: 16),
                                  child: Image.asset("assets/images/ca98fe7d-fe0e-46bd-a3d6-7b5c32de8b76.png",fit: BoxFit.fill,)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 24,bottom: 8,top: 8),
                    child: Text("Stress Busters",style: AppTextStyles.font_poppins.copyWith(color: Color(0xFF000000),fontSize: 16,),),
                  ),
                  Container(
                    height: height*0.15,
                    margin: EdgeInsets.only(left: 16,right: 16,bottom: 16),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Card(
                          color: Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: SizedBox(
                            width: width*0.37,
                          ),
                        ),
                        SizedBox(width: 8,),
                        Card(
                          color: Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: SizedBox(
                            width: width*0.37,
                          ),
                        ),
                        SizedBox(width: 8,),
                        Card(
                          color: Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: SizedBox(
                            width: width*0.37,
                          ),
                        ),
                        SizedBox(width: 8,),
                        Card(
                          color: Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: SizedBox(
                            width: width*0.37,
                          ),
                        ),
                        SizedBox(width: 8,),
                        Card(
                          color: Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: SizedBox(
                            width: width*0.37,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
