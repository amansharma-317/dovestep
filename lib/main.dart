import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:startup/core/api/notification_api.dart';
import 'package:startup/feautures/auth/presentation/screens/myhomepage.dart';
import 'package:startup/feautures/auth/presentation/screens/splash_screen.dart';
import 'package:startup/feautures/auth/presentation/screens/wrapper.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ' + message.messageId.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //final notificationApi = NotificationApi();
  //await notificationApi.initNotifications();
  //await notificationApi.initPushNotifications();
  //await notificationApi.initInfo();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(ProviderScope(child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dovestep',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}