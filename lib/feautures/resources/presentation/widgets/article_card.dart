import 'package:flutter/material.dart';
import 'package:startup/config/utils/const.dart';

class ArticleCard extends StatelessWidget {
  ArticleCard({Key? key, required this.index, required this.title}) : super(key: key);
  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    String bgImageUrl = '';
    Color textColor = Colors.black;

    int maxLines = 3;
    double fontSize = 16;

    if (screenWidth < 400) {
      maxLines = 2;
      fontSize = 14;
    }

    if (index % 4 == 0 || index % 4 == 4 || index % 4 == 8) {
      bgImageUrl = 'assets/images/articles_bg_balloon.png';
    } else if (index % 2 == 0) {
      bgImageUrl = 'assets/images/articles_bg_heart.png';
    } else {
      bgImageUrl = 'assets/images/articles_bg_bulb.png';
    }

    if (index.isOdd) {
      textColor = Colors.white;
    }

    return Container(
      //width: 200,
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(bgImageUrl),
          fit: BoxFit.fill,
        ),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          title,
          style: AppTextStyles.font_lato.copyWith(fontSize: fontSize, fontWeight: FontWeight.w500, color: textColor),
          maxLines: maxLines, // Limit to 3 lines
          overflow: TextOverflow.ellipsis,
          softWrap: true,
        ),
      ),
    );
  }
}
