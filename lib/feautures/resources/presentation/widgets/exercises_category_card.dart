import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

    List<String> imagePaths = [
      'assets/images/self-esteem.svg',
      'assets/images/anxiety.svg',
      'assets/images/sleep.svg',
      'assets/images/Stress.svg',
    ];

    return Container(
      padding: EdgeInsets.all(8),
      decoration: decoration,
      width: 100.0,
      height: 100.0,
      child: Column(
        children: [
          Expanded(
              flex: 4,
              child: SvgPicture.asset(imagePaths[index], fit: BoxFit.fill,),),
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
