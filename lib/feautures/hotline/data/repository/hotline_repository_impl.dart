import 'package:startup/feautures/hotline/data/datasources/hotline_remote_data_source.dart';
import 'package:startup/feautures/hotline/domain/repository/hotline_repository.dart';

class HotlineRepositoryImpl implements HotlineRepository {
  final HotlineRemoteDataSource remoteDataSource;

  HotlineRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> callHotline() async {
    await remoteDataSource.callHotline(
    );
  }
  @override
  Future<int> getHotlineCountForUser() async {
    return await remoteDataSource.getHotlineCountForUser();
  }
}
