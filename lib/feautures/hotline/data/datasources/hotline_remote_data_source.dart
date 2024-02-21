import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HotlineRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebase = FirebaseAuth.instance;


  Future<void> callHotline() async {
    try {
      await _firestore.collection('hotline').add({
        'userId': firebase.currentUser?.uid,
        'timestamp': DateTime.now(),
      });
    } catch (e) {
      print('Error logging hotline usage: $e');
      throw Exception('Failed to log hotline usage');
    }
  }

  Future<int> getHotlineCountForUser() async {
    try {
      final timestamp24HoursAgo = DateTime.now().subtract(
          const Duration(hours: 24));
      final QuerySnapshot querySnapshot = await _firestore
          .collection('hotline')
          .where('userId', isEqualTo: firebase.currentUser?.uid)
          .where('timestamp', isGreaterThanOrEqualTo: timestamp24HoursAgo)
          .get();
      print(querySnapshot.size + 2);
      return querySnapshot.size;
    } catch (e) {
      print('Error fetching hotline count for user within 24 hours: $e');
      throw Exception('Failed to fetch hotline count for user within 24 hours');
    }
  }
}