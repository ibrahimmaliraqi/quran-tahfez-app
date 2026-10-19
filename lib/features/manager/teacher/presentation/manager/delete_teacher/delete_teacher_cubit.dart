import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:quran_tahfez/core/domain/teacher/repo/teacher_repo.dart';

part 'delete_teacher_state.dart';

class DeleteTeacherCubit extends Cubit<DeleteTeacherState> {
  final TeacherRepo teacherRepo;

  DeleteTeacherCubit({
    required this.teacherRepo,
  }) : super(DeleteTeacherInitial());

  Future<void> deleteTeacher({
    required String teacherId,
  }) async {
    emit(DeleteTeacherLoading());

    final result = await teacherRepo.deleteTeacher(teacherId: teacherId);

    result.fold(
      (failure) {
        emit(DeleteTeacherFailure(errMessage: failure.message));
      },
      (message) {
        emit(DeleteTeacherSuccess(message: message));
      },
    );
  }
}
