import '../entities/auth_entity.dart';

abstract class AuthRepo {
  Future<AuthEntity> getAuth();
}