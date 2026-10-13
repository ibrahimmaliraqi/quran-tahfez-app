import 'package:quran_tahfez/core/domain/teacher/entities/teacher_entity.dart';

class TeacherModel {
  int? id;
  int? managerId;
  int? userId;
  String? teacherName;
  String? email;
  String? phone;
  bool? isActive;
  String? createdAt;

  TeacherModel({
    this.id,
    this.managerId,
    this.userId,
    this.teacherName,
    this.email,
    this.phone,
    this.isActive,
    this.createdAt,
  });
  TeacherEntity toEntity() {
    return TeacherEntity(
      id: id,
      managerId: managerId,
      userId: userId,
      teacherName: teacherName,
      email: email,
      phone: phone,
      isActive: isActive,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'managerId': managerId,
      'userId': userId,
      'teacherName': teacherName,
      'email': email,
      'phone': phone,
      'isActive': isActive,
      'createdAt': createdAt,
    };
  }

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
      id: map['id'] != null ? map['id'] as int : null,
      managerId: map['managerId'] != null ? map['managerId'] as int : null,
      userId: map['userId'] != null ? map['userId'] as int : null,
      teacherName: map['teacherName'] != null
          ? map['teacherName'] as String
          : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      isActive: map['isActive'] != null ? map['isActive'] as bool : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }
}
