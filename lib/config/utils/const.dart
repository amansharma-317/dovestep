import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class AppTextStyles{
  static final font_poppins = TextStyle(
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontSize: 20.0,
    fontStyle: FontStyle.normal,
    color: Colors.black,
    fontWeight: FontWeight.w500,
    height: 1,
  );
  static final font_lato = TextStyle(
    fontFamily: GoogleFonts.lato().fontFamily,
    fontSize: 20.0,
    fontStyle: FontStyle.normal,
    color: Colors.black,
    fontWeight: FontWeight.w500,
    height: 1,
  );

}

class ResourcesCardGreen {
  final double width;

  const ResourcesCardGreen({required this.width});

  Card buildCard(BuildContext context) {
    return Card(
      color: Color(0x5088AB8E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SizedBox(
        width: width,
      ),
    );
  }
}class ResourcesCardGrey {
  final double width;

  const ResourcesCardGrey({required this.width});

  Card buildCard(BuildContext context) {
    return Card(
      color: Color(0xFFD9D9D9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SizedBox(
        width: width,
      ),
    );
  }
}