import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../providers/timer_provider.dart';
import 'widgets/timer.dart';
import 'package:startup/feautures/auth/presentation/screens/dashboard.dart';
import 'package:startup/feautures/auth/presentation/screens/otp_screen.dart';
import '../../../../config/utils/const.dart';
import '../../presentation/providers/auth_provider.dart';

class MyHomePage extends ConsumerWidget {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isAuthenticated = ref.watch(authStateNotifierProvider);
    if(isAuthenticated) {
      return Dashboard();
    } else {
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
                  Text("Mobile Number", style: AppTextStyles.font_poppins.copyWith(fontSize: 28,fontWeight: FontWeight.w500),),
                  SizedBox(height: height*0.01,),
                  Text("You will receive a 6-digit number \n to verify your phone number.",
                    style: AppTextStyles.font_lato.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w100,height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height*0.06,),
                  TextField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min, // This ensures the prefix stays compact
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '+91 ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18// Adjust color as needed
                              ),
                            ),
                          ],
                        ),
                      ),
                      hintText: 'Enter numbers only',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                  SizedBox(height: height*0.18,),
                  if (!isAuthenticated)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF27405A),
                        fixedSize: Size(width, height*0.06),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                      onPressed: () async {
                        // Trigger phone number verification
                        String formattedPhoneNumber = '+91' + _phoneNumberController.text;
                        print("object");
                        print("hi" + formattedPhoneNumber);
                        await ref.read(authStateNotifierProvider.notifier)
                            .verifyPhoneNumber(formattedPhoneNumber);
                        ref.read(timerControllerProvider).startTimer();
                        ref.read(timerDurationProvider.notifier).state = Duration(seconds: 30);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OTPScreen(phone: formattedPhoneNumber,),
                          ),
                        );
                      },
                      //child: Text(isAuthenticated ? 'Get OTP' : 'Verify OTP'),
                      child: Text('Submit', style: AppTextStyles.font_poppins.copyWith(
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
}
