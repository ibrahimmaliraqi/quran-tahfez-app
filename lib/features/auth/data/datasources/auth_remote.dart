import 'package:quran_tahfez/core/error/app_exceptions.dart';
import 'package:quran_tahfez/core/network/dio_client.dart';
import 'package:quran_tahfez/features/auth/data/models/user_model.dart';
import 'package:quran_tahfez/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemote {
  Future<UserModel> login({
    required String email,
    required String password,
  });
  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
    required String role,
    required String createdAt,
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
      print("Response: $res");
      print("Response type: ${res.runtimeType}");
      if (res["success"] == true) {
        return UserModel.fromMap(res['data']['user']);
      }
      throw ServerException(errMessage: res['message']);
    } on ServerException {
      rethrow;
    } catch (e) {
      print(e);
      throw ServerException(errMessage: "حدث خطا غير متوقع");
    }
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
    required String role,
    required String createdAt,
  }) async {
    try {
      final res = await dioClient.post(
        "users/register.php",
        data: {
          "name": name,
          "email": email,
          "password": password,
          "role": role,
          "created_at": createdAt,
        },
      );
      print("Response: $res");
      print("Response type: ${res.runtimeType}");
      if (res["success"] == true) {
        return UserModel.fromMap(res['data']['user']);
      }
      throw ServerException(errMessage: res['message']);
    } on ServerException {
      rethrow;
    } catch (e) {
      print(e);
      throw ServerException(errMessage: "حدث خطا غير متوقع");
    }
  }
}

class SupabaseAuthRemoteImpl implements AuthRemote {
  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await supabase.auth.signInWithPassword(
        password: password,
        email: email,
      );
      final userData = res.user;
      if (userData == null) {
        throw ServerException(errMessage: "لا توجد بيانات للمستخدم");
      }
      return UserModel.fromSupabaseUser(userData);
    } on AuthException catch (e) {
      if (e.code == 'invalid_credentials') {
        throw ServerException(
          errMessage: 'البريد الإلكتروني أو كلمة المرور غير صحيحة.',
        );
      } else if (e.code == 'email_not_confirmed') {
        throw ServerException(
          errMessage: 'يرجى تأكيد بريدك الإلكتروني أولاً.',
        );
      } else if (e.code == 'user_banned') {
        throw ServerException(
          errMessage: 'تم حظر هذا الحساب، يرجى التواصل مع الإدارة.',
        );
      } else if (e.code == 'user_already_exists') {
        throw ServerException(
          errMessage: 'البريد الإلكتروني مستخدم مسبقاً.',
        );
      } else if (e.code == 'weak_password') {
        throw ServerException(
          errMessage: 'كلمة المرور ضعيفة جداً.',
        );
      } else if (e.code == 'signup_disabled') {
        throw ServerException(
          errMessage: 'التسجيل مغلق حالياً.',
        );
      } else if (e.code == 'over_request_rate_limit' ||
          e.code == 'over_email_send_rate_limit') {
        throw ServerException(
          errMessage: 'تم إرسال عدة طلبات مؤخراً، يرجى الانتظار قليلاً.',
        );
      } else if (e.code == 'validation_failed') {
        throw ServerException(
          errMessage: 'تأكد من كتابة البريد الإلكتروني بشكل صحيح.',
        );
      } else {
        throw ServerException(
          errMessage: 'حدث خطأ غير متوقع، حاول مرة أخرى.',
        );
      }
    }
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
    required String role,
    required String createdAt,
  }) async {
    try {
      final res = await supabase.auth.signUp(
        password: password,
        email: email,
        data: {
          "is_active": true,
          "role": role,
          "name": name,
        },
      );
      final userData = res.user;
      if (userData == null) {
        throw ServerException(errMessage: "اليوزر لا يحتوي على داتا");
      }
      return UserModel.fromSupabaseUser(userData);
    } on AuthException catch (e) {
      if (e.code == "user_already_exists") {
        throw ServerException(
          errMessage: "هذا البريد الإلكتروني مسجل بالفعل، يمكنك تسجيل الدخول.",
        );
      }
      if (e.code == "weak_password") {
        throw ServerException(
          errMessage: "كلمة المرور ضعيفة جداً، يرجى إدخال كلمة أقوى.",
        );
      }
      if (e.code == 'over_request_rate_limit' ||
          e.code == 'over_email_send_rate_limit') {
        throw ServerException(
          errMessage: "تم إرسال طلبات كثيرة، يرجى الانتظار والمحاولة لاحقاً.",
        );
      }
      if (e.code == "validation_failed") {
        throw ServerException(
          errMessage: "تأكد من صحة البيانات المدخلة وصيغة البريد.",
        );
      }
      if (e.code == "unexpected_failure") {
        throw ServerException(
          errMessage: "حدث خطأ غير متوقع، حاول مرة أخرى.",
        );
      } else {
        throw ServerException(
          errMessage: 'حدث خطأ غير متوقع، حاول مرة أخرى.',
        );
      }
    }
  }
}
