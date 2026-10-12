import '../../domain/entities/teacher_entity.dart';
import '../../domain/repositories/teacher_repo.dart';

class TeacherRepoImpl implements TeacherRepo {
  @override
  Future<TeacherEntity> getTeacher() async {
    throw UnimplementedError();
  }
}