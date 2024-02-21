import 'package:startup/feautures/resources/data/datasources/exercises_data_sources.dart';
import 'package:startup/feautures/resources/domain/entities/exercise_entity.dart';
import 'package:startup/feautures/resources/domain/repository/exercises_repository.dart';


class ExerciseRepositoryImpl implements ExerciseRepository{
  final ExerciseRemoteDataSource _remoteDataSource;

  ExerciseRepositoryImpl(this._remoteDataSource);

  Future<List<String>> fetchUniqueExerciseCategories() async {
    return _remoteDataSource.fetchUniqueExerciseCategories();

  }
  Future<List<ExerciseEntity>> getExercisesByCategory(String categoryName) {
    return _remoteDataSource.getExercisesByCategory(categoryName);
  }
}
