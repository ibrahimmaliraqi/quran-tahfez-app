import 'package:dartz/dartz.dart';
import 'package:quran_tahfez/core/error/failure.dart';

import '../entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });
  Future<void> saveUser({required UserEntity user});
}
