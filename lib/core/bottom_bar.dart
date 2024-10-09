import 'package:flutter/material.dart';
import 'package:startup/core/api/check_for_update.dart';
import 'package:startup/feautures/auth/presentation/screens/dashboard.dart';
import 'package:startup/feautures/community/presentation/screens/community_screens.dart';
import 'package:startup/feautures/resources/presentation/screens/resources_screen.dart';
import 'package:startup/feautures/therapist_directory/presentation/screens/overlay.dart';
import 'package:startup/feautures/therapist_directory/presentation/screens/therapists_directory_screen.dart';
import 'package:startup/feautures/users_profile/presentation/screens/profile.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  @override
  void initState() {
    super.initState();
    checkForUpdate(context);
  }

  int _currentIndex = 2 ;
  List<Widget> body =  [
    CommunityScreen(),
    ResourcesScreen(),
    Dashboard(),
    UnderDevelopmentOverlay(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.teal, // Set the selected color here
        unselectedItemColor: Color(0xff3A4454),
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.group,size: 27,),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb,size: 27,),
            label: 'Resources',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home,size: 27,),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_rounded,size: 27,),
            label: 'Therapist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle,size: 27,),
            label: 'Profile',
          ),

        ],
      ),
      body: body[_currentIndex],
    );
  }
}