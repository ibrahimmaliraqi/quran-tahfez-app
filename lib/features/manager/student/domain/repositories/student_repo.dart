import '../entities/student_entity.dart';

abstract class StudentRepo {
  Future<StudentEntity> getStudent();
}