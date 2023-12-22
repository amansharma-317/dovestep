import 'package:startup/feautures/auth/data/data_sources/auth_data_source.dart';
import 'package:startup/feautures/auth/domain/repository/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebasePhoneDataSource dataSource;

  FirebaseAuthRepository(this.dataSource);

  @override
  Future<void> sendOTP(String phoneNumber) async {
    await dataSource.sendOTP(phoneNumber);
  }

  @override
  Future<bool> verifyOTP(String smsCode) async {
    final result = await dataSource.verifyOTP(smsCode);
    return result != null; // Return true if authentication is successful
  }
}

