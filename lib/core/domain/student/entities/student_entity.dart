class StudentEntity {
  final int id;
  final String managerId;
  final String teacherId;
  final String? teacherName;
  final String userId;
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

  const StudentEntity({
    required this.id,
    required this.managerId,
    required this.teacherName,
    required this.teacherId,
    required this.userId,
    required this.studentName,
    required this.email,
    required this.phone,
    required this.parentPhone,
    this.image,
    required this.nearestLandmark,
    required this.educationLevel,
    required this.lastPage,
    required this.age,
    required this.createdAt,
  });
}
