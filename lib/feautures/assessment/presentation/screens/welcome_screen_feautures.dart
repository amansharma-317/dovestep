import 'package:flutter/material.dart';
import 'package:startup/feautures/assessment/presentation/screens/question1.dart';

class WelcomeScreenFeatures extends StatelessWidget {
  const WelcomeScreenFeatures({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            SizedBox(height: height*0.25,),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.5,
              child: Text('welcome2'),
            ),
          ),

          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Question1()),
                );
              },
              child: Text('Proceed')),
          ],
        ),
      ),
    ),
    );
  }
}
