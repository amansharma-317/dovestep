abstract class AuthRepository {
  Future<void> sendOTP(String phoneNumber);
  Future<bool> verifyOTP(String smsCode);
}
//abstract classes act as a blueprint for other classes to inherit from and specialize further
//serves as a template for its child classes, cannot be instantiated directly


