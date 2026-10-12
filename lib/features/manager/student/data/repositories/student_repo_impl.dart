import '../../domain/entities/student_entity.dart';
import '../../domain/repositories/student_repo.dart';

class StudentRepoImpl implements StudentRepo {
  @override
  Future<StudentEntity> getStudent() async {
    throw UnimplementedError();
  }
}