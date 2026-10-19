import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quran_tahfez/core/domain/teacher/entities/teacher_entity.dart';
import 'package:quran_tahfez/core/domain/teacher/repo/teacher_repo.dart';

part 'get_teachers_state.dart';

class GetTeachersCubit extends Cubit<GetTeachersState> {
  final TeacherRepo teacherRepo;

  GetTeachersCubit({required this.teacherRepo}) : super(GetTeachersInitial());

  Future<void> getTeachers({required String managerId}) async {
    emit(GetTeachersLoading());

    final result = await teacherRepo.getTeachers(managerId: managerId);

    result.fold(
      (failure) {
        emit(GetTeachersFailure(errMessage: failure.message));
      },
      (teachers) {
        emit(GetTeachersSuccess(teachers: teachers));
      },
    );
  }
}
