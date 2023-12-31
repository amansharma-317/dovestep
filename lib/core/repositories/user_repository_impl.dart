import 'package:startup/core/data_sources/user_data_source.dart';
import 'package:startup/feautures/assessment/data/data_source/assessment_data_source.dart';
import 'user_repository.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _dataSource;

  UserRepositoryImpl(this._dataSource);

  @override
  Future<UserProfile> getUserData() async {
    // Implement logic to fetch user data using the data source
    return await _dataSource.fetchUserData();
  }
}
