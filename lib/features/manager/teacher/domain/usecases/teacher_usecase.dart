import '../entities/teacher_entity.dart';
import '../repositories/teacher_repo.dart';

class TeacherUseCase {
  final TeacherRepo repository;

  TeacherUseCase({
    required this.repository,
  });

  Future<TeacherEntity> call() async {
    return repository.getTeacher();
  }
}