import '../entities/teacher_entity.dart';

abstract class TeacherRepo {
  Future<TeacherEntity> getTeacher();
}