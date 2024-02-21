// presentation_layer/providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:startup/feautures/resources/data/datasources/exercises_data_sources.dart';
import 'package:startup/feautures/resources/data/repositories/exercises_repository_impl.dart';
import 'package:startup/feautures/resources/domain/entities/exercise_entity.dart';
import 'package:startup/feautures/resources/domain/repository/exercises_repository.dart';

final exerciseRemoteDataSourceProvider =
Provider<ExerciseRemoteDataSource>((ref) => ExerciseRemoteDataSource());

final exerciseRepositoryProvider = FutureProvider<ExerciseRepository>((ref) async {
  final remoteDataSource = ref.watch(exerciseRemoteDataSourceProvider);
  return ExerciseRepositoryImpl(remoteDataSource);
});

final exerciseCategoriesProvider = FutureProvider<List<String>>((ref) async {
  final repository = await ref.watch(exerciseRepositoryProvider.future);
  return repository.fetchUniqueExerciseCategories();
});

final exercisesByCategoryProvider = FutureProvider.family<List<ExerciseEntity>, String>((ref, categoryName) async {
  final repository = await ref.watch(exerciseRepositoryProvider.future);
  return repository.getExercisesByCategory(categoryName);
});

