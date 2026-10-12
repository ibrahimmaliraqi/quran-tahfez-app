import 'package:quran_tahfez/core/error/app_exceptions.dart';
import 'package:quran_tahfez/core/network/dio_client.dart';
import 'package:quran_tahfez/features/auth/data/models/user_model.dart';

abstract class AuthRemote {
  Future<UserModel> login({
    required String email,
    required String password,
  });
}

class ApiAuthRemote implements AuthRemote {
  final DioClient dioClient;

  ApiAuthRemote({required this.dioClient});
  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await dioClient.post(
        "users/login.php",
        data: {"email": email, "password": password},
      );
      if (res["success"] == true) {
        return UserModel.fromMap(res['data']['user']);
      }
      throw ServerException(errMessage: res['message']);
    } catch (e) {
      throw ServerException(errMessage: "حدث خطا غير متوقع");
    }
  }
}
