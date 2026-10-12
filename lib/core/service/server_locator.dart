import 'package:get_it/get_it.dart';
import 'package:quran_tahfez/core/network/dio_client.dart';
import 'package:quran_tahfez/features/auth/data/datasources/auth_remote.dart';
import 'package:quran_tahfez/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:quran_tahfez/features/auth/domain/repositories/auth_repo.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  //Services
  getIt.registerSingleton<DioClient>(DioClient());
  getIt.registerSingleton<AuthRemote>(
    ApiAuthRemote(dioClient: getIt.get<DioClient>()),
  );

  //repo
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(authRemote: getIt.get<AuthRemote>()),
  );
}
