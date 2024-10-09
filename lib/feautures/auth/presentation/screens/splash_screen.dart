import 'package:flutter/material.dart';
import 'package:startup/feautures/auth/presentation/screens/dashboard.dart';
import 'package:startup/feautures/auth/presentation/screens/wrapper.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Wrapper()),
        );
      });
    });

    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      body: Container(
        color: Color(0xffEEEEEE),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height*0.5,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/appstore.png',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}