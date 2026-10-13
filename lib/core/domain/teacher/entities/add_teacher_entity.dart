class AddTeacherEntity {
  final String teacherName;
  final String email;
  final String password;
  final int managerId;
  final String phone;
  final String createdAt;

  AddTeacherEntity({
    required this.teacherName,
    required this.email,
    required this.password,
    required this.managerId,
    required this.phone,
    required this.createdAt,
  });
}
