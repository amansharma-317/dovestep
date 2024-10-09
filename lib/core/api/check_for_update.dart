import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<void> checkForUpdate(BuildContext context) async {
  try {
    // Fetch the current app version
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;

    // Fetch the latest version from Firestore
    final firestore = FirebaseFirestore.instance;
    final doc = await firestore.collection('config').doc('app_version').get();
    final latestVersion = doc.data()?['latest_version'] ?? '';

    // Compare versions and show update dialog if needed
    if (latestVersion != currentVersion) {
      _showUpdateDialog(context);
    }
  } catch (e) {
    print('Error checking for updates: $e');
  }
}

void _showUpdateDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Update Required'),
        content: Text('A new version of the app is available. Please update to continue.'),
        actions: [
          TextButton(
            onPressed: () async {
              final url = 'https://play.google.com/apps/internaltest/4701538544895385523'; // Replace with your app's URL
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: Text('Update'),
          ),
        ],
      );
    },
  );
}