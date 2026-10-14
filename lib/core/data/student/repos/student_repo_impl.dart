import 'package:dartz/dartz.dart';
import 'package:quran_tahfez/core/constants/app_string.dart';
import 'package:quran_tahfez/core/data/student/data_source/student_remote.dart';
import 'package:quran_tahfez/core/data/student/model/add_student_model.dart';
import 'package:quran_tahfez/core/domain/student/entities/add_student_entity.dart';
import 'package:quran_tahfez/core/domain/student/entities/student_entity.dart';
import 'package:quran_tahfez/core/domain/student/repo/student_repo.dart';
import 'package:quran_tahfez/core/error/app_exceptions.dart';
import 'package:quran_tahfez/core/error/failure.dart';
import 'package:quran_tahfez/features/auth/data/datasources/auth_remote.dart';

class StudentRepoImpl implements StudentRepo {
  final AuthRemote authRemote;
  final StudentRemote studentRemote;

  StudentRepoImpl({required this.authRemote, required this.studentRemote});
  @override
  Future<Either<Failure, StudentEntity>> addStudent({
    required AddStudentEntity data,
  }) async {
    try {
      final res = await authRemote.register(
        email: data.email,
        password: data.password,
        name: data.studentName,
        role: "student",
        createdAt: AppString.currentTime,
      );
      final res2 = await studentRemote.addStudent(
        data: AddStudentModel.fromEntity(data).copyWith(userId: res.id),
      );
      return right(res2.toEntity());
    } on AppExceptions catch (e) {
      return left(ServerFailure(message: e.errMessage));
    }
  }

  @override
  Future<Either<Failure, List<StudentEntity>>> getStudents({
    required int managerId,
  }) async {
    try {
      final res = await studentRemote.getStudents(managerId: managerId);
      return right(res.map((studentModel) => studentModel.toEntity()).toList());
    } on AppExceptions catch (e) {
      return left(ServerFailure(message: e.errMessage));
    }
  }
}
