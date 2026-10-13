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
  Future<Either<Failure, TeacherEntity>> addTeacher({
    required AddTeacherEntity data,
  }) async {
    try {
      final res = await teacherRemote.addTeacher(
        data: AddTeacherModel.fromEntity(data),
      );
      return right(res.toEntity());
    } on AppExceptions catch (e) {
      return left(ServerFailure(message: e.errMessage));
    }
  }
}
