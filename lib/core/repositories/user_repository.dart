import 'package:startup/core/models/user_model.dart';

abstract class UserRepository {
  Future<UserProfile?> getUserData();
}