import 'package:dartz/dartz.dart';
import 'package:quran_tahfez/core/error/failure.dart';

import '../entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
    required String name,
    required String role,
    required String createdAt,
  });
  Future<void> saveUser({required UserEntity user});
}
