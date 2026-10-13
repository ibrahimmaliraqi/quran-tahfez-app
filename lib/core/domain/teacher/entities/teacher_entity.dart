class TeacherEntity {
  final int id;
  final int managerId;
  final int userId;
  final String teacherName;
  final String email;
  final String phone;
  final bool isActive;
  final String createdAt;

  TeacherEntity({
    required this.id,
    required this.managerId,
    required this.userId,
    required this.teacherName,
    required this.email,
    required this.phone,
    required this.isActive,
    required this.createdAt,
  });
}
