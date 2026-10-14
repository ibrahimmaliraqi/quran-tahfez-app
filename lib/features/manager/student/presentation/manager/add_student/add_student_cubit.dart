import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quran_tahfez/core/domain/student/entities/add_student_entity.dart';
import 'package:quran_tahfez/core/domain/student/entities/student_entity.dart';
import 'package:quran_tahfez/core/domain/student/repo/student_repo.dart';

part 'add_student_state.dart';

class AddStudentCubit extends Cubit<AddStudentState> {
  final StudentRepo studentRepo;
  AddStudentCubit({required this.studentRepo}) : super(AddStudentInitial());

  Future<void> addStudent({required AddStudentEntity data}) async {
    emit(AddStudentLoading());
    final res = await studentRepo.addStudent(data: data);
    res.fold(
      (l) => emit(AddStudentFailure(errMessage: l.message)),
      (r) => emit(AddStudentSuccess(student: r)),
    );
  }
}
