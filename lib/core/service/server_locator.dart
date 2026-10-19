import 'package:get_it/get_it.dart';
import 'package:quran_tahfez/core/data/storage_remote/storage_remote.dart';
import 'package:quran_tahfez/core/data/storage_repo/storage_repo_impl.dart';
import 'package:quran_tahfez/core/data/student/data_source/student_remote.dart';
import 'package:quran_tahfez/core/data/student/repos/student_repo_impl.dart';
import 'package:quran_tahfez/core/data/teacher/datasource/teacher_remote.dart';
import 'package:quran_tahfez/core/data/teacher/repo/teacher_repo_impl.dart';
import 'package:quran_tahfez/core/domain/storage_repo/storage_repo.dart';
import 'package:quran_tahfez/core/domain/student/repo/student_repo.dart';
import 'package:quran_tahfez/core/domain/teacher/repo/teacher_repo.dart';
import 'package:quran_tahfez/core/network/dio_client.dart';
import 'package:quran_tahfez/features/auth/data/datasources/auth_remote.dart';
import 'package:quran_tahfez/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:quran_tahfez/features/auth/domain/repositories/auth_repo.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  //Services
  getIt.registerSingleton<DioClient>(DioClient());
  // getIt.registerSingleton<AuthRemote>(
  //   ApiAuthRemote(dioClient: getIt.get<DioClient>()),
  // );
  getIt.registerSingleton<AuthRemote>(
    SupabaseAuthRemoteImpl(),
  );
  getIt.registerSingleton<TeacherRemote>(
    ApiTeacherRemoteImpl(dioClient: getIt.get<DioClient>()),
  );
  getIt.registerSingleton<StudentRemote>(
    ApiStudentRemoteImpl(dioClient: getIt.get<DioClient>()),
  );
  getIt.registerSingleton<StorageRemote>(
    ApiImgbbImpl(dioClient: getIt.get<DioClient>()),
  );

  //repo
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(authRemote: getIt.get<AuthRemote>()),
  );
  getIt.registerSingleton<TeacherRepo>(
    TeacherRepoImpl(teacherRemote: getIt.get<TeacherRemote>()),
  );
  getIt.registerSingleton<StorageRepo>(
    StorageRepoImpl(storageRemote: getIt.get<StorageRemote>()),
  );
  getIt.registerSingleton<StudentRepo>(
    StudentRepoImpl(
      studentRemote: getIt.get<StudentRemote>(),
      authRemote: getIt.get<AuthRemote>(),
    ),
  );
}
