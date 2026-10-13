import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quran_tahfez/core/domain/teacher/entities/add_teacher_entity.dart';
import 'package:quran_tahfez/core/domain/teacher/entities/teacher_entity.dart';
import 'package:quran_tahfez/core/domain/teacher/repo/teacher_repo.dart';

part 'add_teacher_state.dart';

class AddTeacherCubit extends Cubit<AddTeacherState> {
  final TeacherRepo teacherRepo;
  AddTeacherCubit({required this.teacherRepo}) : super(AddTeacherInitial());

  Future<void> addTeacher({required AddTeacherEntity data}) async {
    emit(AddTeacherLoading());

    final res = await teacherRepo.addTeacher(data: data);
    res.fold(
      (l) => emit(AddTeacherFailure(errMessage: l.message)),
      (r) => emit(AddTeacherSuccess(teachers: r)),
    );
  }
}
