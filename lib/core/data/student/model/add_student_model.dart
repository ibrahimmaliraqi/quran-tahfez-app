// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:quran_tahfez/core/domain/student/entities/add_student_entity.dart';

class AddStudentModel {
  final int? userId;
  final String managerId;
  final int teacherId;
  final String studentName;
  final String email;
  final File image;
  final String phone;
  final String password;
  final String parentPhone;
  final String imageUrl;
  final String nearestLandmark;
  final String educationLevel;
  final int lastPage;
  final int age;
  final String createdAt;

  AddStudentModel({
    this.userId,
    required this.password,
    required this.image,
    required this.managerId,
    required this.teacherId,
    required this.studentName,
    required this.email,
    required this.phone,
    required this.parentPhone,
    required this.imageUrl,
    required this.nearestLandmark,
    required this.educationLevel,
    required this.lastPage,
    required this.age,
    required this.createdAt,
  });
  AddStudentEntity toEntity() {
    return AddStudentEntity(
      image: image,
      userId: userId,
      managerId: managerId,
      teacherId: teacherId,
      studentName: studentName,
      email: email,
      phone: phone,
      password: password,
      parentPhone: parentPhone,
      imageUrl: imageUrl,
      nearestLandmark: nearestLandmark,
      educationLevel: educationLevel,
      lastPage: lastPage,
      age: age,
      createdAt: createdAt,
    );
  }

  factory AddStudentModel.fromEntity(AddStudentEntity entity) {
    return AddStudentModel(
      image: entity.image,
      userId: entity.userId,
      managerId: entity.managerId,
      teacherId: entity.teacherId,
      studentName: entity.studentName,
      email: entity.email,
      phone: entity.phone,
      password: entity.password,
      parentPhone: entity.parentPhone,
      imageUrl: entity.imageUrl,
      nearestLandmark: entity.nearestLandmark,
      educationLevel: entity.educationLevel,
      lastPage: entity.lastPage,
      age: entity.age,
      createdAt: entity.createdAt,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'manager_id': managerId,
      'teacher_id': teacherId,
      'student_name': studentName,
      'email': email,
      'phone': phone,
      'parent_phone': parentPhone,
      'image': imageUrl,
      'nearest_landmark': nearestLandmark,
      'education_level': educationLevel,
      'last_page': lastPage,
      'age': age,
      'created_at': createdAt,
    };
  }

  AddStudentModel copyWith({
    int? userId,
    String? managerId,
    int? teacherId,
    String? studentName,
    String? email,
    String? phone,
    String? password,
    String? parentPhone,
    File? image,
    String? imageUrl,
    String? nearestLandmark,
    String? educationLevel,
    int? lastPage,
    int? age,
    String? createdAt,
  }) {
    return AddStudentModel(
      image: image ?? File(""),
      userId: userId ?? this.userId,
      managerId: managerId ?? this.managerId,
      teacherId: teacherId ?? this.teacherId,
      studentName: studentName ?? this.studentName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      parentPhone: parentPhone ?? this.parentPhone,
      imageUrl: imageUrl ?? this.imageUrl,
      nearestLandmark: nearestLandmark ?? this.nearestLandmark,
      educationLevel: educationLevel ?? this.educationLevel,
      lastPage: lastPage ?? this.lastPage,
      age: age ?? this.age,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
