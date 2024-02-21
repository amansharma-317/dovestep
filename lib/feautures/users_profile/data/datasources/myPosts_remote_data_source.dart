
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startup/feautures/community/domain/entities/post_entity.dart';

class FirestorePostsRemoteDataSource {
  final FirebaseFirestore _firestore;

  FirestorePostsRemoteDataSource(this._firestore);

  Future<List<PostEntity>> getPostsByUserId(String userId) async {
    final querySnapshot = await _firestore
        .collection('posts')
        .where('userId', isEqualTo: userId)
        .get();

    return querySnapshot.docs.map((doc) => PostEntity.fromMap(doc.data())).toList();
  }
}
