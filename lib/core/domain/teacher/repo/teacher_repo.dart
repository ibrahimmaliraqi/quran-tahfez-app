import 'package:dartz/dartz.dart';
import 'package:quran_tahfez/core/domain/teacher/entities/add_teacher_entity.dart';
import 'package:quran_tahfez/core/domain/teacher/entities/teacher_entity.dart';
import 'package:quran_tahfez/core/error/failure.dart';

abstract class TeacherRepo {
  Future<Either<Failure, TeacherEntity>> addTeacher({
    required AddTeacherEntity data,
  });
  Future<Either<Failure, List<TeacherEntity>>> getTeachers({
    required int managerId,
  });
  Future<Either<Failure, String>> deleteTeacher({
    required int teacherId,
  });
}
