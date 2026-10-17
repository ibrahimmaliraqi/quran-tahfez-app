import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quran_tahfez/core/data/teacher/model/add_teacher_model.dart';
import 'package:quran_tahfez/core/domain/storage_repo/storage_repo.dart';
import 'package:quran_tahfez/core/domain/teacher/entities/add_teacher_entity.dart';
import 'package:quran_tahfez/core/domain/teacher/entities/teacher_entity.dart';
import 'package:quran_tahfez/core/domain/teacher/repo/teacher_repo.dart';

part 'add_teacher_state.dart';

class AddTeacherCubit extends Cubit<AddTeacherState> {
  final TeacherRepo teacherRepo;
  final StorageRepo storageRepo;
  AddTeacherCubit({required this.teacherRepo, required this.storageRepo})
    : super(AddTeacherInitial());

  Future<void> addTeacher({required AddTeacherEntity data}) async {
    emit(AddTeacherLoading());
    final res = await storageRepo.uploadImage(image: data.image ?? File(""));
    res.fold(
      (l) => emit(AddTeacherFailure(errMessage: l.message)),
      (imageUrl) async {
        AddTeacherEntity teacherEntity = AddTeacherModel.fromEntity(
          data,
        ).copyWith(imageUrl: imageUrl).toEntity();
        final ress = await teacherRepo.addTeacher(data: teacherEntity);
        ress.fold(
          (l) => emit(AddTeacherFailure(errMessage: l.message)),
          (teacher) {
            emit(AddTeacherSuccess(teachers: teacher));
          },
        );
      },
    );
  }
}
