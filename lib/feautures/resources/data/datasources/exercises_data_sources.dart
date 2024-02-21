import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startup/feautures/resources/domain/entities/exercise_entity.dart';

class ExerciseRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> fetchUniqueExerciseCategories() async {
    final QuerySnapshot snapshot =
    await _firestore.collection('exercises').get();

    final List<String> uniqueCategories = [];

    for (final QueryDocumentSnapshot doc in snapshot.docs) {
      final String category = doc['category'];
      if (!uniqueCategories.contains(category)) {
        uniqueCategories.add(category);
      }
    }
    return uniqueCategories;
  }
  Future<List<ExerciseEntity>> getExercisesByCategory(String categoryName) async {
    try {
      final snapshot = await _firestore
          .collection('exercises')
          .where('category', isEqualTo: categoryName)
          .get();
      return snapshot.docs.map((doc) => ExerciseEntity.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to fetch exercises by category: $e');
    }
  }
}