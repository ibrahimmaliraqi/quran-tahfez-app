// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:quran_tahfez/core/domain/teacher/entities/add_teacher_entity.dart';

class AddTeacherModel {
  final String teacherName;
  final String email;
  final String password;
  final String managerId;
  final String phone;
  final String? imageUrl;
  final File? image;
  final String createdAt;
  AddTeacherModel({
    required this.imageUrl,
    required this.teacherName,
    required this.email,
    this.image,
    required this.password,
    required this.managerId,
    required this.phone,
    required this.createdAt,
  });
  AddTeacherEntity toEntity() {
    return AddTeacherEntity(
      teacherName: teacherName,
      email: email,
      imageUrl: imageUrl,
      password: password,
      managerId: managerId,
      phone: phone,
      image: image,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'teacher_name': teacherName,
      'email': email,
      'password': password,
      'manager_id': managerId,
      'phone': phone,
      'image_url': imageUrl,
      'created_at': createdAt,
    };
  }

  factory AddTeacherModel.fromEntity(AddTeacherEntity entity) {
    return AddTeacherModel(
      imageUrl: entity.imageUrl,
      image: entity.image,
      createdAt: entity.createdAt,
      teacherName: entity.teacherName,

      email: entity.email,
      password: entity.password,
      managerId: entity.managerId,
      phone: entity.phone,
    );
  }

  AddTeacherModel copyWith({
    String? teacherName,
    String? email,
    String? password,
    String? managerId,
    String? phone,
    String? imageUrl,
    File? image,
    String? createdAt,
  }) {
    return AddTeacherModel(
      imageUrl: imageUrl ?? this.teacherName,
      teacherName: teacherName ?? this.teacherName,
      email: email ?? this.email,
      password: password ?? this.password,
      managerId: managerId ?? this.managerId,
      phone: phone ?? this.phone,
      image: image ?? this.image,

      createdAt: createdAt ?? this.createdAt,
    );
  }
}
