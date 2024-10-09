import 'package:flutter/material.dart';
import 'package:startup/config/utils/const.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Scaffold(
          backgroundColor: Color(0xFFEEEEEE),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xffEEEEEE),
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.black),
            title:  Text("Privacy Policy",style: AppTextStyles.font_poppins.copyWith(fontSize: 20,fontWeight: FontWeight.w400),),
          ),
        ),
      ),
    );
  }
}
