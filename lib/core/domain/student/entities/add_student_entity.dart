import 'dart:io';

class AddStudentEntity {
  final String? userId;
  final String managerId;
  final String teacherId;
  final String studentName;
  final String email;
  final String phone;
  final File image;
  final String password;
  final String parentPhone;
  final String imageUrl;
  final String nearestLandmark;
  final String educationLevel;
  final int lastPage;
  final int age;
  final String createdAt;

  const AddStudentEntity({
    this.userId,
    required this.password,
    required this.managerId,
    required this.teacherId,
    required this.image,
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
}
