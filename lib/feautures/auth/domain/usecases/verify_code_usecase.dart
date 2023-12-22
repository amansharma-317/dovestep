/*
class VerifyCodeUseCase {
  final AuthRepository _repository;

  VerifyCodeUseCase(this._repository);

  Future<User> verifyCode(String phoneNumber, String verificationCode) async {
    // Validate phone number and code format
    if (!isValidPhoneNumber(phoneNumber) || !isValidVerificationCode(verificationCode)) {
      throw InvalidCodeException();
    }

    // Verify code and retrieve user data
    final user = await _repository.verifyCode(phoneNumber, verificationCode);

    // Handle successful verification and return user data
    return user;
  }
}
*/


import 'package:startup/core/usecase.dart';
import 'package:startup/feautures/auth/domain/auth_params.dart';
import 'package:startup/feautures/auth/domain/repository/auth_repository.dart';

class SendOTPUseCase implements UseCase<void, AuthParams> {
  final AuthRepository repository;

  SendOTPUseCase(this.repository);

  @override
  Future<void> call(AuthParams params) async {
    // Validate parameters (if necessary)

    await repository.sendOTP(params.phoneNumber);
    // Perform any additional logic if needed
  }
}

class VerifyOTPUseCase implements UseCase<bool, VerifyOTPParams> {
  final AuthRepository repository;

  VerifyOTPUseCase(this.repository);

  @override
  Future<bool> call(VerifyOTPParams params) async {
    // Validate parameters (if necessary)

    return await repository.verifyOTP(params.smsCode);
  }
}