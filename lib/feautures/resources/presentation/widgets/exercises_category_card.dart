import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExercisesCategoryCard extends StatelessWidget {
  ExercisesCategoryCard({Key? key, required this.index, required this.categoryName}) : super(key: key);
  final int index;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.transparent;

    BoxDecoration decoration;

    if (index.isEven) {
      bgColor = Color(0xff88AB8E);
      decoration = BoxDecoration(
        color: bgColor, // Background color
        borderRadius: BorderRadius.circular(10.0), // Rounded border
      );
    } else {
      decoration = BoxDecoration(
        border: Border.all(color: Color(0xff88AB8E), width: 2.0), // Border color and weight
        borderRadius: BorderRadius.circular(10.0), // Rounded border
      );
    }

    return Container(
      padding: EdgeInsets.all(8),
      decoration: decoration,
      width: 100.0,
      height: 100.0,
      child: Column(
        children: [
          Expanded(
              flex: 4,
              child: Image.network('https://img.freepik.com/free-vector/happy-freelancer-with-computer-home-young-man-sitting-armchair-using-laptop-chatting-online-smiling-vector-illustration-distance-work-online-learning-freelance_74855-8401.jpg?w=1060&t=st=1706620112~exp=1706620712~hmac=1907980c6101679c01dbc100abdfbba840b5d80a55ef41ead6d4c0b4f8b3a51b')),
          SizedBox(height: 8,),
          Expanded(
            flex: 1,
            child: Text(
              categoryName,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.black,
                  letterSpacing: 1,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
