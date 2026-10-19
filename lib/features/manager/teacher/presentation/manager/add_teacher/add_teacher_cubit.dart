import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quran_tahfez/core/constants/app_string.dart';
import 'package:quran_tahfez/core/data/teacher/model/add_teacher_model.dart';
import 'package:quran_tahfez/core/domain/storage_repo/storage_repo.dart';
import 'package:quran_tahfez/core/domain/teacher/entities/add_teacher_entity.dart';
import 'package:quran_tahfez/core/domain/teacher/repo/teacher_repo.dart';
import 'package:quran_tahfez/features/auth/domain/repositories/auth_repo.dart';

part 'add_teacher_state.dart';

class AddTeacherCubit extends Cubit<AddTeacherState> {
  final TeacherRepo teacherRepo;
  final StorageRepo storageRepo;
  final AuthRepo authRepo;
  AddTeacherCubit({
    required this.teacherRepo,
    required this.storageRepo,
    required this.authRepo,
  }) : super(AddTeacherInitial());

  Future<void> addTeacher({required AddTeacherEntity data}) async {
    emit(AddTeacherLoading());
    final res = await storageRepo.uploadImage(image: data.image ?? File(""));
    res.fold(
      (l) => emit(AddTeacherFailure(errMessage: l.message)),
      (imageUrl) async {
        final authRes = await authRepo.register(
          email: data.email,
          password: data.password,
          name: data.teacherName,
          role: "teacher",
          createdAt: AppString.currentTime,
        );
        authRes.fold(
          (l) async {
            emit(AddTeacherFailure(errMessage: l.message));
          },
          (r) async {
            AddTeacherEntity teacherEntity = AddTeacherModel.fromEntity(
              data,
            ).copyWith(imageUrl: imageUrl, userId: r.id).toEntity();
            final ress = await teacherRepo.addTeacher(data: teacherEntity);
            ress.fold(
              (l) => emit(AddTeacherFailure(errMessage: l.message)),
              (teacher) {
                emit(AddTeacherSuccess());
              },
            );
          },
        );
      },
    );
  }
}
