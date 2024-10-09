import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:startup/config/utils/const.dart';
import 'package:startup/feautures/auth/presentation/screens/myhomepage.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height*0.1,),
              Expanded(
                  child: SvgPicture.asset('assets/images/brainlock.svg',)
              ),
              SizedBox(height: height*0.05,),
              FittedBox(
                child: Text("Welcome Home", style: AppTextStyles.font_poppins.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.w500),),
              ),
              SizedBox(height: 10,),
              FittedBox(
                child: Text("Where You Belong, You're Valued, \n and You're Not Alone",
                  style: AppTextStyles.font_lato.copyWith(
                    fontSize: 20,fontWeight: FontWeight.w100,
                    height:1.3,letterSpacing: 0),
                  textAlign: TextAlign.center,),
              ),
              SizedBox(height: 30,),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
              },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF27405A),
                    fixedSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                  ),
                  child:Text("-->", style: AppTextStyles.font_poppins.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold,fontSize: 30),
                  )
              ),
              SizedBox(height: height*0.05,)

            ],
          ),
        ),
      ),
    );
  }
}
