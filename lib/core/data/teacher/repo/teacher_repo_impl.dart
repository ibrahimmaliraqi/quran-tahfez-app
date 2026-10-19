import 'package:dartz/dartz.dart';
import 'package:quran_tahfez/core/data/teacher/datasource/teacher_remote.dart';
import 'package:quran_tahfez/core/data/teacher/model/add_teacher_model.dart';
import 'package:quran_tahfez/core/domain/teacher/entities/add_teacher_entity.dart';
import 'package:quran_tahfez/core/domain/teacher/entities/teacher_entity.dart';
import 'package:quran_tahfez/core/domain/teacher/repo/teacher_repo.dart';
import 'package:quran_tahfez/core/error/app_exceptions.dart';
import 'package:quran_tahfez/core/error/failure.dart';

class TeacherRepoImpl implements TeacherRepo {
  final TeacherRemote teacherRemote;

  TeacherRepoImpl({required this.teacherRemote});
  @override
  Future<Either<Failure, void>> addTeacher({
    required AddTeacherEntity data,
  }) async {
    try {
      await teacherRemote.addTeacher(
        data: AddTeacherModel.fromEntity(data),
      );
      return right(null);
    } on AppExceptions catch (e) {
      return left(ServerFailure(message: e.errMessage));
    }
  }

  @override
  Future<Either<Failure, List<TeacherEntity>>> getTeachers({
    required String managerId,
  }) async {
    try {
      final res = await teacherRemote.getTeachers(managerId: managerId);
      return right(res.map((teacherModel) => teacherModel.toEntity()).toList());
    } on AppExceptions catch (e) {
      return left(ServerFailure(message: e.errMessage));
    }
  }

  @override
  Future<Either<Failure, String>> deleteTeacher({
    required int teacherId,
  }) async {
    try {
      final res = await teacherRemote.deleteTeacher(teacherId: teacherId);
      return right(res);
    } on AppExceptions catch (e) {
      return left(ServerFailure(message: e.errMessage));
    }
  }
}
