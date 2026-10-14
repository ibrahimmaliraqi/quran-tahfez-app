import 'package:quran_tahfez/core/data/student/model/add_student_model.dart';
import 'package:quran_tahfez/core/data/student/model/student_model.dart';
import 'package:quran_tahfez/core/error/app_exceptions.dart';
import 'package:quran_tahfez/core/network/dio_client.dart';

abstract class StudentRemote {
  Future<StudentModel> addStudent({
    required AddStudentModel data,
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
      if (e is ServerException) rethrow;

      throw ServerException(
        errMessage: 'حدث خطأ غير متوقع',
      );
    }
  }
}
