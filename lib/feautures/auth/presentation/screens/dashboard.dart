import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:startup/config/utils/const.dart';
import 'package:startup/core/models/user_model.dart';
import 'package:startup/core/providers/user_provider.dart';
import 'package:startup/feautures/auth/presentation/widgets/dashboard_article.dart';
import 'package:startup/feautures/auth/presentation/widgets/dashboard_article_card.dart';
import 'package:startup/feautures/chat/presentation/providers/matching_provider.dart';
import 'package:startup/feautures/chat/presentation/screens/my_chats.dart';
import 'package:startup/feautures/hotline/presentation/screens/hotline_screen.dart';
import 'package:startup/feautures/resources/presentation/providers/article_providers.dart';
import 'package:startup/feautures/resources/presentation/screens/article_content.dart';
import 'package:startup/feautures/resources/presentation/widgets/article_card.dart';
import 'package:startup/feautures/therapist_directory/presentation/screens/overlay.dart';
import 'package:startup/feautures/therapist_directory/presentation/screens/therapists_directory_screen.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  Widget build(BuildContext context) {

    // AsyncValue<UserProfile> userProfile = ref.watch(userDataProvider);
    final userProfileFuture = ref.watch(userDataProvider);
    const double minFontSize = 14.0;
    const double maxFontSize = 24.0;
    const double breakpoint1 = 320.0;
    const double breakpoint2 = 768.0;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double fontSize = minFontSize;
    if (width <= breakpoint1) {
      fontSize = minFontSize;
    } else if (width <= breakpoint2) {
      fontSize = (minFontSize + maxFontSize) / 2;
    } else {
      fontSize = maxFontSize;
    }

    //for the subtitle text for buttons
    const double minFontSizeForSubtitle = 12.0;
    const double maxFontSizeForSubtitle = 16.0;
    double fontSizeForSubtitle = minFontSizeForSubtitle;

    if (width <= breakpoint1) {
      fontSizeForSubtitle = minFontSizeForSubtitle;
    } else if (width <= breakpoint2) {
      fontSizeForSubtitle = (minFontSizeForSubtitle + maxFontSizeForSubtitle) / 2;
    } else {
      fontSizeForSubtitle = maxFontSizeForSubtitle;
    }

    double topPadding = 0;

    if (width > 720 && height > 1280) {
      topPadding = height * 0.25 - 24;  // Larger phones (e.g., phablets)
    } else if (width > 600 && height > 1024) {
      topPadding = height * 0.2 - 20;   // Medium-large phones
    } else if (width > 480 && height > 854) {
      topPadding = height * 0.18 - 16;  // Medium phones
    } else if (width > 400 && height > 800) {
      topPadding = height * 0.15 - 12;  // Smaller phones
    } else if (width >= 360 && height > 800) {
      topPadding = height * 0.17 - 16;  // Small phones (larger height)
    } else if (width >= 360 && height > 720 && height <= 800) {
      topPadding = height * 0.17 - 16;  // Small phones (medium height)
    } else if (width >= 360 && height > 640 && height <= 720) {
      topPadding = height * 0.2 - 16;  // Small phones (shorter height)
    } else if (width > 360 && height > 560 && height <= 640) {
      topPadding = height * 0.13 - 16;  // Very small phones (larger height)
    } else if (width > 320 && height > 480 && height <= 560) {
      topPadding = height * 0.12 - 16;  // Very small phones (medium height)
    }  else if (width > 320 && height > 560) {
      topPadding = height * 0.2 - 16;  // Very small phones (medium height)
    } else if (width > 320 && height <= 480) {
      topPadding = height * 0.1 - 16;   // Very small phones (shorter height)
    } else {
      topPadding = height * 0.22 - 16;   // Default for very small phones
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFFEEEEEE),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //appbar and big-box stack
                Stack(
                      fit: StackFit.passthrough,
                      children: [
                        Container(
                          //constraints: BoxConstraints.expand(),
                              width: width,
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
                                  userProfileFuture.when(data: (user) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: CircleAvatar(
                                                child: SvgPicture.string(
                                                  user!.avatar,
                                                  semanticsLabel: 'Profile Picture',
                                                  placeholderBuilder: (BuildContext context) => Container(
                                                    padding: const EdgeInsets.all(20.0),
                                                    child: Center(child: const CircularProgressIndicator()),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => MyChats()));
                                              },
                                              child: Icon(Icons.chat_bubble_outline,),
                                            )
                                        ),
                                        SizedBox(width: 16,),
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: Icon(Icons.notifications_none_rounded,)
                                        ),
                                      ],
                                    );
                                  },
                                    error: (error, stackTrace) => Text("Error fetching data: $error"),
                                    loading: () => Center(child: CircularProgressIndicator()),
                                  ),
                                  SizedBox(height: height*0.01,),
                                  userProfileFuture.when(
                                    data: (user) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FittedBox(
                                            child: Text("Hello,", style: AppTextStyles.font_lato.copyWith(fontSize: fontSize),),
                                            fit: BoxFit.fitHeight,
                                            alignment: Alignment.centerLeft,
                                          ),
                                          SizedBox(height: 0.01,),
                                          FittedBox(
                                            alignment: Alignment.centerLeft,
                                            fit: BoxFit.fitHeight,
                                            child: Text(
                                              user!.username,
                                              style: AppTextStyles.font_poppins.copyWith(fontSize: fontSize, fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          SizedBox(height: 16,),
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
                        //if(topBarHeight > 0)
                          Padding(
                            padding: EdgeInsets.only(top: topPadding),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 16 ),
                              width: width-32,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Color(0xFFB0C8AB),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  FittedBox(
                                      child: Text("Support is a tap away!",style: AppTextStyles.font_poppins.copyWith(fontSize: width*0.06,color: Color(0xFF000000),fontWeight: FontWeight.bold,letterSpacing: 2),)
                                  ),
                                  SizedBox(height: height * 0.01,),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: height*0.15,
                                              child: SvgPicture.asset('assets/images/peersupport.svg', fit: BoxFit.fill,),
                                            ),

                                            SizedBox(height: height * 0.01,),
                                            Text("Chat with someone who can relate.",style: AppTextStyles.font_lato.copyWith(fontSize: fontSizeForSubtitle,fontWeight: FontWeight.w300,color: Color(0xff000000)),
                                                textAlign: TextAlign.center,
                                                ),
                                            SizedBox(height: height * 0.01,),
                                            userProfileFuture.when(
                                              data: (user) {
                                                return Consumer(
                                                    builder: (context, watch, child) {
                                                      return ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: Color(0xFF27405A),
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                            fixedSize: Size(width*0.4, height*0.05),
                                                            elevation: 0,
                                                          ),
                                                          onPressed: () async {
                                                            try {
                                                              print('chat now button pressed, onpressed functionality initiated');
                                                              final result = await ref.read(matchUserProvider(user!.assessmentResponses).future);
                                                              print('result is: ' + result.toString());

                                                              if (result.success == false) {
                                                                showPlatformDialog(
                                                                  context: context,
                                                                  builder: (context) => BasicDialogAlert(
                                                                    title: Text(result.errorMessage.toString()),
                                                                    actions: <Widget>[
                                                                      BasicDialogAction(
                                                                        title: Text("OK"),
                                                                        onPressed: () {
                                                                          Navigator.pop(context);
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              } else if (result.success == true) {
                                                                Navigator.push(context, MaterialPageRoute(builder: (context) => MyChats()));
                                                              }
                                                            } catch (error) {
                                                              Fluttertoast.showToast(msg: "Error fetching data: $error");
                                                            }
                                                          },

                                                          child: FittedBox(
                                                              child: Text("Talk & Share",style: AppTextStyles.font_poppins.copyWith(fontSize: height*0.017,fontWeight: FontWeight.w700,color: Color(0xFFFBFBFB),letterSpacing: 1),))
                                                      );
                                                    }
                                                );
                                              },
                                              error: (error, stackTrace) => Text("Error fetching data: $error"),
                                              loading: () => Center(child: CircularProgressIndicator()),
                                            ),

                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              height: height * 0.15,
                                              //width: width * 0.25,
                                              child: SvgPicture.asset('assets/images/Group 2.svg', fit: BoxFit.contain,),
                                            ),
                                            SizedBox(height: height * 0.01,),
                                            Text(
                                              "Find emergency help instantly.",
                                              style: AppTextStyles.font_lato.copyWith(fontSize: fontSizeForSubtitle,fontWeight: FontWeight.w300,color: Color(0xff000000)
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(height: height*0.01,),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Color(0xFFC60404),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                  fixedSize: Size(width*0.4, height*0.05),
                                                  elevation: 0,
                                                ),
                                                onPressed: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => HotlineScreen()));
                                                },
                                                child: FittedBox(
                                                  child: Text(
                                                    "Instant Help",
                                                    style: AppTextStyles.font_poppins.copyWith(fontSize: height*0.017,fontWeight: FontWeight.w700,color: Color(0xFFFBFBFB),letterSpacing: 1),
                                                  ),
                                                )
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),



                SizedBox(height: height*0.02,),

                Container(
                  height: height*0.185,
                  margin: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 12),
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
                              SizedBox(height: 8,),
                              Text("Let's open up to the things that",style: AppTextStyles.font_poppins.copyWith(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xFF393938)),),
                              SizedBox(height: 8,),
                              Text("matter the most",style: AppTextStyles.font_poppins.copyWith(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xFF393938)),),
                              SizedBox(height: 12,),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => UnderDevelopmentOverlay()),
                                  );
                                },
                                child: Row(
                                  children: [
                                    FittedBox(child: Text("Book Now",style: AppTextStyles.font_poppins.copyWith(fontSize: 18,fontWeight: FontWeight.bold,letterSpacing: 1,color: Color(0xFF27405A)),)),
                                    SizedBox(width: 8,),
                                    Container(
                                        height: 14,
                                        width: 14,
                                        child: Image.asset("assets/images/af3984a0-4f50-45c0-b655-7c79aff67ab9.png",fit: BoxFit.fill,)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Container(
                              //height: 168,
                                padding: EdgeInsets.only(top: 32,bottom: 16,right: 16),
                                child: Image.asset("assets/images/ca98fe7d-fe0e-46bd-a3d6-7b5c32de8b76.png",fit: BoxFit.fill,)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 24,bottom: 8,top: 8),
                  child: Text("Articles",style: AppTextStyles.font_poppins.copyWith(color: Color(0xFF000000),fontSize: 16,),),
                ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              //height: height * 0.4, // Adjust the height according to your needs
              width: width,
              child: ref.watch(articlesProvider).when(
                data: (articles) {
                  print('length of articles ' + articles.length.toString());
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two elements per row
                      childAspectRatio: (2) / (1), // Adjust child aspect ratio
                    ),
                    itemCount: articles.length > 4 ? 4 : articles.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArticleContent(article: articles[index]),
                            ),
                          );
                        },
                        child: DashboardArticleCard(title: articles[index].title,),
                      );
                    },
                  );
                },
                loading: () => Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Text('Error: $error'),
              ),
            ),

                /*
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
                 */
              ],
            ),
          ),
        ),
      ),
    );
  }
}
