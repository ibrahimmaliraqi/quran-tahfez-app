// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:quran_tahfez/core/domain/teacher/entities/teacher_entity.dart';

class TeacherModel {
  final int id;
  final int managerId;
  final int userId;
  final String teacherName;
  final String email;
  final String? imageUrl;
  final String phone;
  final bool isActive;
  final String createdAt;

  TeacherModel({
    required this.id,
    this.imageUrl,
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
      imageUrl: imageUrl,
      email: email,
      phone: phone,
      isActive: isActive,
      createdAt: createdAt,
    );
  }

  factory TeacherModel.fromEntity(TeacherEntity entity) {
    return TeacherModel(
      id: entity.id,
      managerId: entity.managerId,
      userId: entity.userId,
      imageUrl: entity.imageUrl,
      teacherName: entity.teacherName,
      email: entity.email,
      phone: entity.phone,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
    );
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'managerId': managerId,
      'userId': userId,
      'teacherName': teacherName,
      'email': email,
      'image_url': imageUrl,
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
      imageUrl: map['image_url'],
      teacherName: map['teacher_name'],
      email: map['email'],
      phone: map['phone'],
      isActive: map['is_active'],
      createdAt: map['created_at'],
    );
  }

  TeacherModel copyWith({
    int? id,
    int? managerId,
    int? userId,
    String? teacherName,
    String? email,
    String? imageUrl,
    String? phone,
    bool? isActive,
    String? createdAt,
  }) {
    return TeacherModel(
      id: id ?? this.id,
      managerId: managerId ?? this.managerId,
      userId: userId ?? this.userId,
      teacherName: teacherName ?? this.teacherName,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      phone: phone ?? this.phone,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
