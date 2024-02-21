import 'package:flutter/material.dart';
import 'package:startup/config/utils/const.dart';

class TherapistsRowDetails extends StatelessWidget {
  final String experience;
  final String totalPatients;

  TherapistsRowDetails({required this.experience, required this.totalPatients});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xff27405A),
              child: Icon(Icons.people_alt, color: Colors.white, size: 24),
            ),
            SizedBox(height: 8),
            Text(
              'Clients',
              style:  AppTextStyles.font_poppins.copyWith(color: Color(0xff27405A),fontSize: 14,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              totalPatients + "+",
              style:  AppTextStyles.font_lato.copyWith(color: Color(0xff27405A),fontSize: 14,fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Column(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xff27405A),
              child: Icon(Icons.cases_sharp, color: Colors.white, size: 24),
              ),
            SizedBox(height: 8), // Adding some space between the icon and text
            Text(
              'Experience',
              style:  AppTextStyles.font_poppins.copyWith(color: Color(0xff27405A),fontSize: 14,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              experience + '+ years',
              style:  AppTextStyles.font_lato.copyWith(color: Color(0xff27405A),fontSize: 14,fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
