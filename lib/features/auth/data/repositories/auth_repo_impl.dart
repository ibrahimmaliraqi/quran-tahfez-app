import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<AuthEntity> getAuth() async {
    throw UnimplementedError();
  }
}