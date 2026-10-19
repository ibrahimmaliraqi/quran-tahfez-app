import 'package:quran_tahfez/features/auth/domain/entities/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

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
  factory UserModel.fromSupabaseUser(supabase.User user) {
    final metadata = user.userMetadata ?? {};

    return UserModel(
      // معرّف جدول المستخدمين إذا كنت تمرره في الـ metadata، وإلا يترك null
      id: int.parse(user.id),
      name: metadata['name'] as String?,
      email: user.email,
      role: metadata['role'] as String?,
      createdAt: user.createdAt,
      isActive: metadata['is_active'] != null
          ? metadata['is_active'] as bool
          : true,
    );
  }
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
