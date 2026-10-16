import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:quran_tahfez/core/error/failure.dart';

abstract class StorageRepo {
  Future<Either<Failure, String>> uploadImage({required File image});
}
