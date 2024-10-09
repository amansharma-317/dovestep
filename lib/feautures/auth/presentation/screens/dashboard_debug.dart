import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:startup/config/utils/const.dart';
import 'package:startup/feautures/chat/presentation/providers/matching_provider.dart';

class DashboardDebug extends StatelessWidget {
  const DashboardDebug({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    double topPadding = 0;if (width > 768) {
      topPadding = height * 0.2 - 24;  // Large screens
    } else if (width > 480) {
      topPadding = height * 0.15 - 16;  // Medium screens
    } else {
      topPadding = height * 0.1 - 8;   // Small screens
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: CircleAvatar(),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {

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
                          ),
                          SizedBox(height: height*0.01,),
                          Column(
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
                                  'username',
                                  style: AppTextStyles.font_poppins.copyWith(fontSize: fontSize, fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(height: 16,),
                            ],
                          ),

                          // Text("username",style: AppTextStyles.font_poppins,),
                        ],
                      ),
                    ),
                    //SizedBox(height: 16,),
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
                                          width: width * 0.25,
                                          child: SvgPicture.asset('assets/images/sleep.svg', fit: BoxFit.fill,),
                                        ),

                                        SizedBox(height: height * 0.01,),
                                        FittedBox(
                                            child: Text("Reach Out, Speak Up",style: AppTextStyles.font_lato.copyWith(fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff000000)),)
                                        ),
                                        SizedBox(height: height * 0.01,),
                                        Consumer(
                                            builder: (context, watch, child) {
                                              return ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Color(0xFF27405A),
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                    fixedSize: Size(width*0.4, height*0.05),
                                                    elevation: 0,
                                                  ),
                                                  onPressed: () async {},

                                                  child: FittedBox(
                                                      child: Text("Chat Now",style: AppTextStyles.font_poppins.copyWith(fontSize: height*0.017,fontWeight: FontWeight.w700,color: Color(0xFFFBFBFB),letterSpacing: 1),))
                                              );
                                            }
                                        ),


                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Container(
                                          height: height * 0.15,
                                          width: width * 0.25,
                                          child: SvgPicture.asset('assets/images/Stress.svg', fit: BoxFit.fill,),
                                        ),
                                        SizedBox(height: height * 0.01,),
                                        FittedBox(
                                          child: Text(
                                            "Emergency Help",
                                            style: AppTextStyles.font_lato.copyWith(fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff000000)
                                            ),
                                          ),
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
