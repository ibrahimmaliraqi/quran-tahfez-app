import 'package:dartz/dartz.dart';
import 'package:quran_tahfez/core/domain/student/entities/add_student_entity.dart';
import 'package:quran_tahfez/core/domain/student/entities/student_entity.dart';
import 'package:quran_tahfez/core/error/failure.dart';

abstract class StudentRepo {
  Future<Either<Failure, StudentEntity>> addStudent({
    required AddStudentEntity data,
  });
}
