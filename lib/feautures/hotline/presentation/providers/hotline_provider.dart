import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:startup/feautures/hotline/data/datasources/hotline_remote_data_source.dart';
import 'package:startup/feautures/hotline/data/repository/hotline_repository_impl.dart';
import 'package:startup/feautures/hotline/domain/repository/hotline_repository.dart';

final hotlineRemoteDataSourceProvider = Provider<HotlineRemoteDataSource>((ref) {
  return HotlineRemoteDataSource();
});



// Provider for HotlineRepository
final hotlineRepositoryProvider = Provider<HotlineRepository>((ref) {
  final remoteDataSource = ref.watch(hotlineRemoteDataSourceProvider);
  return HotlineRepositoryImpl(remoteDataSource: remoteDataSource);
});

// Provider for calling the hotline
final hotlineCallProvider = FutureProvider.autoDispose<void>((ref) async {
  final repository = ref.read(hotlineRepositoryProvider);
  await repository.callHotline();
});

final hotlineCountProvider = FutureProvider.autoDispose<int>((ref) async {
  final repository = ref.read(hotlineRepositoryProvider);
  print(repository );
  return repository.getHotlineCountForUser();
});
