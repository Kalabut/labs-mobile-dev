import 'package:lab1_counter/domain/models/user_model.dart';

abstract interface class IAuthRepository {
  Future<void> register(UserModel user);
  Future<UserModel?> login(String email, String password);
  Future<UserModel?> getCurrentUser();
  Future<void> logout();
}
