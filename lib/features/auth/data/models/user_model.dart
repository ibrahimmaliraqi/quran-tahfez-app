import 'package:quran_tahfez/features/auth/domain/entities/user_entity.dart';

class UserModel {
  int? id;
  String? name;
  String? email;
  String? role;
  String? createdAt;
  bool? isActive;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.role,
    this.createdAt,
    this.isActive,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'createdAt': createdAt,
      'isActive': isActive,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      role: role,
      createdAt: createdAt,
      isActive: isActive,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      isActive: map['is_active'] != null ? map['is_active'] as bool : null,
    );
  }
}
