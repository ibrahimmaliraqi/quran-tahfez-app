import '../entities/auth_entity.dart';
import '../repositories/auth_repo.dart';

class AuthUseCase {
  final AuthRepo repository;

  AuthUseCase({
    required this.repository,
  });

  Future<AuthEntity> call() async {
    return repository.getAuth();
  }
}