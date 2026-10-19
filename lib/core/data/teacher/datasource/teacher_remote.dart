import 'package:quran_tahfez/core/data/teacher/model/add_teacher_model.dart';
import 'package:quran_tahfez/core/data/teacher/model/teacher_model.dart';
import 'package:quran_tahfez/core/error/app_exceptions.dart';
import 'package:quran_tahfez/core/network/dio_client.dart';
import 'package:quran_tahfez/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class TeacherRemote {
  Future<void> addTeacher({
    required AddTeacherModel data,
  });
  Future<List<TeacherModel>> getTeachers({
    required String managerId,
  });
  Future<String> deleteTeacher({
    required String teacherId,
  });
}

class ApiTeacherRemoteImpl implements TeacherRemote {
  final DioClient dioClient;

  ApiTeacherRemoteImpl({required this.dioClient});
  @override
  Future<TeacherModel> addTeacher({
    required AddTeacherModel data,
  }) async {
    try {
      final res = await dioClient.post(
        "teachers/add_teacher.php",
        data: data.toMap(),
      );

      if (res['success'] != true) {
        throw ServerException(
          errMessage: res['message'],
        );
      }

      return TeacherModel.fromMap(res['data']['teacher']);
    } catch (e) {
      print(e.toString());
      if (e is ServerException) rethrow;

      throw ServerException(
        errMessage: 'حدث خطأ غير متوقع',
      );
    }
  }

  @override
  Future<List<TeacherModel>> getTeachers({required String managerId}) async {
    try {
      final res = await dioClient.get(
        "teachers/get_teachers.php",

        queryParameters: {"manager_id": managerId},
      );

      if (res['success'] != true) {
        throw ServerException(
          errMessage: res['message'],
        );
      }
      final teachersList = res['data']['teachers'] as List;
      return teachersList
          .map((teacher) => TeacherModel.fromMap(teacher))
          .toList();
    } catch (e) {
      if (e is ServerException) rethrow;

      throw ServerException(
        errMessage: 'حدث خطأ غير متوقع',
      );
    }
  }

  @override
  Future<String> deleteTeacher({required String teacherId}) async {
    try {
      final res = await dioClient.post(
        "teachers/delete_teacher.php",

        data: {"teacher_id": teacherId},
      );

      if (res['success'] != true) {
        throw ServerException(
          errMessage: res['message'],
        );
      }
      return res['message'];
    } catch (e) {
      if (e is ServerException) rethrow;

      throw ServerException(
        errMessage: 'حدث خطأ غير متوقع',
      );
    }
  }
}

class SupabaseTeacherRemoteImpl implements TeacherRemote {
  String getExceptionMessage({required PostgrestException data}) {
    switch (data.code) {
      case "PGRST204":
        return 'تعذر إضافة المعلم.';
      default:
        print(data.code);
        print(data.message);
        return " ${data.message}حدث خطاااا";
    }
  }

  @override
  Future<void> addTeacher({required AddTeacherModel data}) async {
    try {
      await supabase.from("teachers").insert(data.toMap());
    } on PostgrestException catch (e) {
      throw ServerException(errMessage: getExceptionMessage(data: e));
    }
  }

  @override
  Future<String> deleteTeacher({required String teacherId}) async {
    try {
      await supabase.from("users").delete().eq("id", teacherId);
      return "تم حذف المعلم بنجاح";
    } on PostgrestException catch (e) {
      throw ServerException(errMessage: getExceptionMessage(data: e));
    }
  }

  @override
  Future<List<TeacherModel>> getTeachers({required String managerId}) async {
    try {
      final res = await supabase
          .from("teachers")
          .select()
          .eq("manager_id", managerId)
          .order("created_at", ascending: false);
      return res.map((teacher) => TeacherModel.fromMap(teacher)).toList();
    } catch (e) {
      print("e.toString()");
      print(e.toString());
      throw ServerException(errMessage: "فشل في جلب المعلمين");
    }
  }
}
