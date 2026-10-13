class TeacherEntity {
  int? id;
  int? managerId;
  int? userId;
  String? teacherName;
  String? email;
  String? phone;
  bool? isActive;
  String? createdAt;

  TeacherEntity({
    this.id,
    this.managerId,
    this.userId,
    this.teacherName,
    this.email,
    this.phone,
    this.isActive,
    this.createdAt,
  });
}
