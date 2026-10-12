import '../entities/profile_entity.dart';
import '../repositories/profile_repo.dart';

class ProfileUseCase {
  final ProfileRepo repository;

  ProfileUseCase({
    required this.repository,
  });

  Future<ProfileEntity> call() async {
    return repository.getProfile();
  }
}