import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quran_tahfez/core/domain/student/entities/student_entity.dart';
import 'package:quran_tahfez/core/domain/student/repo/student_repo.dart';

part 'get_students_state.dart';

class GetStudentsCubit extends Cubit<GetStudentsState> {
  final StudentRepo studentRepo;

  GetStudentsCubit({required this.studentRepo}) : super(GetStudentsInitial());

  Future<void> getStudents({required int managerId}) async {
    emit(GetStudentsLoading());

    final result = await studentRepo.getStudents(managerId: managerId);

    result.fold(
      (failure) {
        emit(GetStudentsFailure(message: failure.message));
      },
      (students) {
        emit(GetStudentsSuccess(students: students));
      },
    );
  }
}
