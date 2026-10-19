import 'package:quran_tahfez/core/data/student/model/add_student_model.dart';
import 'package:quran_tahfez/core/data/student/model/student_model.dart';
import 'package:quran_tahfez/core/error/app_exceptions.dart';
import 'package:quran_tahfez/core/functions/get_supabase_exc.dart';
import 'package:quran_tahfez/core/network/dio_client.dart';
import 'package:quran_tahfez/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class StudentRemote {
  Future<void> addStudent({
    required AddStudentModel data,
  });
  Future<List<StudentModel>> getStudents({
    required String managerId,
  });
  Future<String> deleteStudent({
    required String studentId,
  });
}

class ApiStudentRemoteImpl implements StudentRemote {
  final DioClient dioClient;

  ApiStudentRemoteImpl({required this.dioClient});
  @override
  Future<StudentModel> addStudent({required AddStudentModel data}) async {
    try {
      final res = await dioClient.post(
        "students/add_student.php",

        data: data.toMap(),
      );

      if (res['success'] != true) {
        throw ServerException(
          errMessage: res['message'],
        );
      }
      return StudentModel.fromMap(res['data']['student']);
    } catch (e) {
      print(" print(e) print(e) print(e) print(e) print(e)");
      print(e);
      if (e is ServerException) rethrow;

      throw ServerException(
        errMessage: 'حدث خطأ غير متوقع',
      );
    }
  }

  @override
  Future<List<StudentModel>> getStudents({required String managerId}) async {
    try {
      final res = await dioClient.post(
        "students/get_students.php",

        data: {"manager_id": managerId},
      );

      if (res['success'] != true) {
        throw ServerException(
          errMessage: res['message'],
        );
      }
      final dataList = res['data']['students'] as List;
      return dataList.map((student) => StudentModel.fromMap(student)).toList();
    } catch (e) {
      if (e is ServerException) rethrow;

      throw ServerException(
        errMessage: 'حدث خطأ غير متوقع',
      );
    }
  }

  @override
  Future<String> deleteStudent({required String studentId}) async {
    try {
      final res = await dioClient.post(
        "students/delete_student.php",

        data: {"user_id": studentId},
      );

      if (res['success'] != true) {
        throw ServerException(
          errMessage: res['message'],
        );
      }
      return res['data']['name'];
    } catch (e) {
      if (e is ServerException) rethrow;

      throw ServerException(
        errMessage: 'حدث خطأ غير متوقع',
      );
    }
  }
}

class SupabaseStudentRemoteImpl implements StudentRemote {
  @override
  Future<void> addStudent({required AddStudentModel data}) async {
    try {
      await supabase.from("students").insert(data.toMap());
    } on PostgrestException catch (e) {
      throw ServerException(errMessage: getExceptionMessage(data: e));
    }
  }

  @override
  Future<String> deleteStudent({required String studentId}) async {
    try {
      await supabase.from("users").delete().eq("id", studentId);
      return "تم حذف الطالب بنجاح";
    } on PostgrestException catch (e) {
      throw ServerException(errMessage: getExceptionMessage(data: e));
    }
  }

  @override
  Future<List<StudentModel>> getStudents({required String managerId}) async {
    try {
      final res = await supabase
          .from('students')
          .select('''
      *,
      teacher:users!students_teacher_id_fkey(
        teachers!teachers_user_id_fkey(
          teacher_name
        )
      )
    ''')
          .eq('manager_id', managerId)
          .order('created_at', ascending: false);

      print(res);
      print(res);
      return res.map((teacher) => StudentModel.fromMap(teacher)).toList();
    } catch (e) {
      print("e.toString()");
      print(e.toString());
      throw ServerException(errMessage: "فشل في جلب المعلمين");
    }
  }
}
