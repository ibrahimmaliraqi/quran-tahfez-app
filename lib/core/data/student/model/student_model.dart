import 'package:quran_tahfez/core/domain/student/entities/student_entity.dart';

class StudentModel {
  final int id;
  final int managerId;
  final int teacherId;
  final String? teacherName;
  final int userId;
  final String studentName;
  final String email;
  final String phone;
  final String parentPhone;
  final String? image;
  final String nearestLandmark;
  final String educationLevel;
  final int lastPage;
  final int age;
  final String createdAt;
  StudentModel({
    required this.id,
    required this.managerId,
    required this.teacherName,
    required this.teacherId,
    required this.userId,
    required this.studentName,
    required this.email,
    required this.phone,
    required this.parentPhone,
    required this.image,
    required this.nearestLandmark,
    required this.educationLevel,
    required this.lastPage,
    required this.age,
    required this.createdAt,
  });
  factory StudentModel.fromMap(Map<String, dynamic> json) {
    return StudentModel(
      teacherName: json['teacher_name'],
      id: json['id'] as int,
      managerId: json['manager_id'] as int,
      teacherId: json['teacher_id'] as int,
      userId: json['user_id'] as int,
      studentName: json['student_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      parentPhone: json['parent_phone'] as String,
      image: json['image'] as String?,
      nearestLandmark: json['nearest_landmark'] as String,
      educationLevel: json['education_level'] as String,
      lastPage: json['last_page'] as int,
      age: json['age'] as int,
      createdAt: json['created_at'] as String,
    );
  }
  StudentEntity toEntity() {
    return StudentEntity(
      id: id,
      managerId: managerId,
      teacherId: teacherId,
      userId: userId,
      studentName: studentName,
      email: email,
      teacherName: teacherName,
      phone: phone,
      parentPhone: parentPhone,
      image: image,
      nearestLandmark: nearestLandmark,
      educationLevel: educationLevel,
      lastPage: lastPage,
      age: age,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'manager_id': managerId,
      'teacher_id': teacherId,
      'user_id': userId,
      'student_name': studentName,
      'email': email,
      'phone': phone,
      'parent_phone': parentPhone,
      'image': image,
      'nearest_landmark': nearestLandmark,
      'education_level': educationLevel,
      'last_page': lastPage,
      'age': age,
      'created_at': createdAt,
    };
  }
}
