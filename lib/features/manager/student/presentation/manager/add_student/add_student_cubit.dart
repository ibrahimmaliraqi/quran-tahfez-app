import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quran_tahfez/core/data/student/model/add_student_model.dart';
import 'package:quran_tahfez/core/domain/storage_repo/storage_repo.dart';
import 'package:quran_tahfez/core/domain/student/entities/add_student_entity.dart';
import 'package:quran_tahfez/core/domain/student/entities/student_entity.dart';
import 'package:quran_tahfez/core/domain/student/repo/student_repo.dart';

part 'add_student_state.dart';

class AddStudentCubit extends Cubit<AddStudentState> {
  final StudentRepo studentRepo;
  final StorageRepo storageRepo;
  AddStudentCubit({required this.studentRepo, required this.storageRepo})
    : super(AddStudentInitial());

  Future<void> addStudent({required AddStudentEntity data}) async {
    emit(AddStudentLoading());
    final res1 = await storageRepo.uploadImage(image: data.image);
    res1.fold(
      (l) => emit(AddStudentFailure(errMessage: l.message)),
      (r) async {
        final AddStudentEntity data1 = AddStudentModel.fromEntity(
          data,
        ).copyWith(imageUrl: r).toEntity();
        final res = await studentRepo.addStudent(data: data1);
        res.fold(
          (l) => emit(AddStudentFailure(errMessage: l.message)),
          (r) => emit(AddStudentSuccess(student: r)),
        );
      },
    );
  }
}
