import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_avatar/random_avatar.dart'; // Ensure this package is added in pubspec.yaml

Future<void> updateUserAvatars() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Fetch all user documents
  QuerySnapshot<Map<String, dynamic>> usersSnapshot = await firestore.collection('users').get();

  // Iterate over each user document
  for (QueryDocumentSnapshot<Map<String, dynamic>> userDoc in usersSnapshot.docs) {
    String userId = userDoc.id;
    String newAvatarUrl = generateRandomAvatar(userId);

    // Update the user's avatar field
    await firestore.collection('users').doc(userId).update({
      'avatar': newAvatarUrl,
    });

    print('Updated avatar for user $userId');
  }
}

String generateRandomAvatar(String userId) {
  return RandomAvatarString(userId, trBackground: true);
}
