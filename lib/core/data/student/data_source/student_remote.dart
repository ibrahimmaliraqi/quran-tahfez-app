import 'package:quran_tahfez/core/data/student/model/add_student_model.dart';
import 'package:quran_tahfez/core/data/student/model/student_model.dart';
import 'package:quran_tahfez/core/error/app_exceptions.dart';
import 'package:quran_tahfez/core/network/dio_client.dart';

abstract class StudentRemote {
  Future<StudentModel> addStudent({
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
