import 'package:flutter/material.dart';

// This widget displays the overlay screen
class UnderDevelopmentOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.3), // Semi-transparent background
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Content won't overflow
            children: [
              Text(
                "This Feature is Under Development",
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              CircularProgressIndicator(), // Or another indicator
            ],
          ),
        ),
      ),
    );
  }
}