import 'package:startup/feautures/resources/domain/entities/exercise_entity.dart';

abstract class ExerciseRepository {
  Future<List<String>> fetchUniqueExerciseCategories();
  Future<List<ExerciseEntity>> getExercisesByCategory(String categoryName);
}