import '../entities/student_entity.dart';
import '../repositories/student_repo.dart';

class StudentUseCase {
  final StudentRepo repository;

  StudentUseCase({
    required this.repository,
  });

  Future<StudentEntity> call() async {
    return repository.getStudent();
  }
}