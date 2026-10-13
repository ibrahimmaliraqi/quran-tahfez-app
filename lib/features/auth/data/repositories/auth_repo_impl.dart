import 'package:dartz/dartz.dart';
import 'package:quran_tahfez/core/error/app_exceptions.dart';
import 'package:quran_tahfez/core/error/failure.dart';
import 'package:quran_tahfez/core/service/prefs_helper.dart';
import 'package:quran_tahfez/features/auth/data/datasources/auth_remote.dart';
import 'package:quran_tahfez/features/auth/domain/entities/user_entity.dart';
import 'package:quran_tahfez/features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemote authRemote;

  AuthRepoImpl({required this.authRemote});
  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await authRemote.login(email: email, password: password);
      UserEntity user = res.toEntity();
      await saveUser(user: user);
      return right(user);
    } on AppExceptions catch (e) {
      return left(ServerFailure(message: e.errMessage));
    }
  }

  @override
  Future<void> saveUser({required UserEntity user}) async {
    await PrefsHelper.saveUser(user);
  }
}
