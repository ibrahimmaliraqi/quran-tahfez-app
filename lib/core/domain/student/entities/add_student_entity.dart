class AddStudentEntity {
  final int? userId;
  final int managerId;
  final int teacherId;
  final String studentName;
  final String email;
  final String phone;
  final String password;
  final String parentPhone;
  final String image;
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
}
