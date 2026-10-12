import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  @override
  Future<ProfileEntity> getProfile() async {
    throw UnimplementedError();
  }
}