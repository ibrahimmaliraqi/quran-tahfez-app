import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quran_tahfez/core/domain/student/entities/student_entity.dart';
import 'package:quran_tahfez/core/domain/student/repo/student_repo.dart';

part 'get_students_state.dart';

class GetStudentsCubit extends Cubit<GetStudentsState> {
  final StudentRepo studentRepo;

  List<StudentEntity> studentsList = [];

  GetStudentsCubit({
    required this.studentRepo,
  }) : super(GetStudentsInitial());

  Future<void> getStudents({required int managerId}) async {
    emit(GetStudentsLoading());

    final result = await studentRepo.getStudents(
      managerId: managerId,
    );

    result.fold(
      (failure) {
        emit(GetStudentsFailure(message: failure.message));
      },
      (students) {
        studentsList = students;

        emit(
          GetStudentsSuccess(students: studentsList),
        );
      },
    );
  }

  Future<void> deleteStudent({required int studentId}) async {
    emit(GetStudentsLoading());

    final result = await studentRepo.deleteStudent(
      studentId: studentId,
    );
    result.fold(
      (l) => emit(GetStudentsFailure(message: l.message)),
      (r) {
        studentsList.removeWhere((student) {
          return student.userId == studentId;
        });
        emit(
          GetStudentsSuccess(students: studentsList),
        );
      },
    );
  }
}
