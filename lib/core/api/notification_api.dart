import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ' + message.notification!.title!);
}

void handleMessage(RemoteMessage message) async {
  if (message == null) return;
  print('Got a message whilst in the foreground!');
  print('Message title: ${message.notification!.title}');

  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');

    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      message.notification!.body.toString(), htmlFormatBigText: true,
      contentTitle: message.notification!.title.toString(), htmlFormatContentTitle: true,
    );
    
    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channelId', 'channelName', importance: Importance.high, styleInformation: bigTextStyleInformation, priority: Priority.high, playSound: true,
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await FlutterLocalNotificationsPlugin().show(0, message.notification!.title, message.notification!.body, platformChannelSpecifics, payload: message.data['title']);
  }
}

class NotificationApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Future<void> initNotifications() async {
    final settings = await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken(); //gets the device token for the current device
    await saveToken(fcmToken.toString());
    print('the device token is ' + fcmToken.toString());
      if(settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted access.');
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        print('User granted provisional permission.');
      } else {
        print('user declined or has not accepted permission.');
      }
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then((value) => handleMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) => handleMessage(message));
  }

  initInfo() {
    var androidInitialize = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(android: androidInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<String> getToken() async {
    String deviceToken = '';
    await FirebaseMessaging.instance.getToken().then((token) {
      deviceToken = token!;
    });
    return deviceToken;
  }

  Future<void> saveToken(String deviceToken) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(currentUserId).update({
      'deviceToken' : deviceToken,
    });
  }

  // ..................CHAT..................................

  String getChatTopic(String chatId) => 'chat_' + chatId;

  Future<void> subscribeToChatTopic(String chatId) async {
    await FirebaseMessaging.instance.subscribeToTopic(getChatTopic(chatId));
  }

  Future<void> unsubscribeFromChatTopic(String chatId) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(getChatTopic(chatId));
  }

}

