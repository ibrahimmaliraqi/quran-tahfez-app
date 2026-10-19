class TeacherEntity {
  final int id;
  final String managerId;
  final String userId;
  final String teacherName;
  final String email;
  final String phone;
  final String? imageUrl;
  final bool isActive;
  final String createdAt;

  TeacherEntity({
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
}
