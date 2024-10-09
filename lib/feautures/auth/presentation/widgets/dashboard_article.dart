import 'package:flutter/material.dart';
import 'package:startup/config/utils/const.dart';

class DashboardArticleCard extends StatelessWidget {
  DashboardArticleCard({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;

    int maxLines = 3;
    double fontSize = 16;

    if (screenWidth < 400) {
      maxLines = 2;
      fontSize = 14;
    }

    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Color(0x3088AB8E),
          borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          title,
          style: AppTextStyles.font_lato.copyWith(fontSize: fontSize, fontWeight: FontWeight.w500, color: Colors.black),
          maxLines: maxLines, // Limit to 3 lines
          overflow: TextOverflow.ellipsis,
          softWrap: true,
        ),
      ),
    );
  }
}
