import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:quran_tahfez/core/data/storage_remote/storage_remote.dart';
import 'package:quran_tahfez/core/domain/storage_repo/storage_repo.dart';
import 'package:quran_tahfez/core/error/app_exceptions.dart';
import 'package:quran_tahfez/core/error/failure.dart';

class StorageRepoImpl implements StorageRepo {
  final StorageRemote storageRemote;

  StorageRepoImpl({required this.storageRemote});
  @override
  Future<Either<Failure, String>> uploadImage({required File image}) async {
    try {
      final res = await storageRemote.uploadImage(image: image);
      return right(res);
    } on AppExceptions catch (e) {
      return left(ServerFailure(message: e.errMessage));
    }
  }
}
