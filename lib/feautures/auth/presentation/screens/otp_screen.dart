import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:startup/feautures/assessment/presentation/providers/assessment_providers.dart';
import 'package:startup/feautures/auth/presentation/providers/auth_provider.dart';
import 'package:startup/feautures/auth/presentation/screens/wrapper.dart';
import '../../../../config/utils/const.dart';
import '../providers/timer_provider.dart';

class OTPScreen extends ConsumerWidget {
  final TextEditingController _otpController = TextEditingController();
  final String phone;

  OTPScreen({required this.phone});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duration = ref.watch(timerDurationProvider);
    final timerState = ref.watch(timerStateProvider);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    String displayDuration(Duration duration) {
      // Get the number of seconds remaining
      int seconds = duration.inSeconds;

      // Handle leading zeros (optional)
      String secondsStr = seconds.toString();
      if (seconds < 10) {
        secondsStr = "0$secondsStr";
      }

      return secondsStr;
    }


    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(32),
            child: Column(
              children: <Widget>[
                SizedBox(height: height*0.08,),
                SvgPicture.asset('assets/images/self-esteem.svg',height: height*0.22,),
                SizedBox(height: height*0.03,),
                Text("Verification Code", style: AppTextStyles.font_poppins.copyWith(fontSize: 28,fontWeight: FontWeight.w500),),
                SizedBox(height: height*0.01,),
                Text("Please enter the verification \ncode sent to ${phone}",
                  style: AppTextStyles.font_lato.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w100,height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height*0.05,),
                TextFormField(
                  controller: _otpController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    hintText: 'Enter OTP',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Change border color to grey
                    ),
                  ),
                ),
                SizedBox(height: height*0.11,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFEEEEEE),
                    fixedSize: Size(width, height*0.06),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Color(0xff27405A)),
                    ),
                  ),
                  onPressed: () async {
                    ref.read(timerDurationProvider.notifier).state = Duration(seconds: 30);
                    ref.read(timerControllerProvider).startTimer();
                    await ref.read(authStateNotifierProvider.notifier)
                        .verifyPhoneNumber(phone);

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(displayDuration(duration),style: AppTextStyles.font_poppins.copyWith(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),),
                      Text(' Resend', style: AppTextStyles.font_poppins.copyWith(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),),
                    ],
                  ),
                ),
                SizedBox(height: height*0.02,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF27405A),
                    fixedSize: Size(width, height*0.06),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () async {
                    print(_otpController.text);
                    bool isOTPVerified = await ref.read(authStateNotifierProvider.notifier).verifyOTP(phone, _otpController.text);
                    print(isOTPVerified);

                    if (isOTPVerified) {
                      print('abcd');
                      ref.refresh(hasCompletedAssessmentProvider);
                      // If OTP is verified, navigate to the dashboard screen
                      Navigator.push(
                        context,
                          MaterialPageRoute(builder: (context) => Wrapper())); // Direct

                    } else {
                      // Handle scenario when OTP is not verified
                      // For example, show a snackbar or display an error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Invalid OTP'),
                        ),
                      );
                    }

                    await ref.read(authStateNotifierProvider.notifier).verifyOTP(phone, _otpController.text);
                  },
                  child: Text('Verify OTP',style: AppTextStyles.font_poppins.copyWith(
                    fontSize: 20,
                    color: Color(0xffFBFBFB),
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
