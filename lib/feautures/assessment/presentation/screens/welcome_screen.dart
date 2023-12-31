import 'package:flutter/material.dart';
import 'package:startup/feautures/assessment/presentation/screens/welcome_screen_feautures.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

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
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage('https://img.freepik.com/free-vector/hand-drawn-collage-background_23-2149590537.jpg?t=st=1703906729~exp=1703907329~hmac=914ad0c93658eefb307c62b2db9d7e70fbfe23d2de06ef0873a3553479117840'), // Replace 'your_image.png' with your image asset
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreenFeatures()),
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
