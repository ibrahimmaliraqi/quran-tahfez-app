import 'dart:io';

class AddTeacherEntity {
  final String teacherName;
  final String email;
  final String password;
  final String managerId;
  final String? userId;
  final String phone;
  final File? image;
  final String? imageUrl;

  final String createdAt;

  AddTeacherEntity({
    required this.teacherName,
    this.userId,
    this.image,
    required this.email,
    this.imageUrl,

    required this.password,
    required this.managerId,
    required this.phone,
    required this.createdAt,
  });
}
