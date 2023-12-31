import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:startup/core/models/user_model.dart';
import '../repositories/user_repository.dart';
import '../repositories/user_repository_impl.dart';
import '../data_sources/user_data_source.dart';

final userDataSourceProvider = Provider<UserDataSource>((ref) => FirebaseUserDataSource());

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final dataSource = ref.read(userDataSourceProvider);
  return UserRepositoryImpl(dataSource);
});

// FutureProvider returns the result of an asynchronous operation.
final userDataProvider = FutureProvider<UserProfile?>((ref) async {
  final repository = ref.read(userRepositoryProvider);
  return await repository.getUserData();
});
