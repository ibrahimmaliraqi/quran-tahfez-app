import 'package:quran_tahfez/core/domain/teacher/entities/teacher_entity.dart';

class TeacherModel {
  final int id;
  final int managerId;
  final int userId;
  final String teacherName;
  final String email;
  final String phone;
  final bool isActive;
  final String createdAt;

  TeacherModel({
    required this.id,
    required this.managerId,
    required this.userId,
    required this.teacherName,
    required this.email,
    required this.phone,
    required this.isActive,
    required this.createdAt,
  });
  TeacherEntity toEntity() {
    return TeacherEntity(
      id: id,
      managerId: managerId,
      userId: userId,
      teacherName: teacherName,
      email: email,
      phone: phone,
      isActive: isActive,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'managerId': managerId,
      'userId': userId,
      'teacherName': teacherName,
      'email': email,
      'phone': phone,
      'isActive': isActive,
      'createdAt': createdAt,
    };
  }

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
      id: map['id'],
      managerId: map['manager_id'],
      userId: map['user_id'],
      teacherName: map['teacher_name'],
      email: map['email'],
      phone: map['phone'],
      isActive: map['is_active'],
      createdAt: map['created_at'],
    );
  }
}
