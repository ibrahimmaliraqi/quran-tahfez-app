import 'package:quran_tahfez/core/domain/teacher/entities/add_teacher_entity.dart';

class AddTeacherModel {
  final String teacherName;
  final String email;
  final String password;
  final int managerId;
  final String phone;
  final String createdAt;
  AddTeacherModel({
    required this.teacherName,
    required this.email,
    required this.password,
    required this.managerId,
    required this.phone,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'teacher_name': teacherName,
      'email': email,
      'password': password,
      'manager_id': managerId,
      'phone': phone,
      'created_at': createdAt,
    };
  }

  factory AddTeacherModel.fromEntity(AddTeacherEntity entity) {
    return AddTeacherModel(
      createdAt: entity.createdAt,
      teacherName: entity.teacherName,
      email: entity.email,
      password: entity.password,
      managerId: entity.managerId,
      phone: entity.phone,
    );
  }
}
