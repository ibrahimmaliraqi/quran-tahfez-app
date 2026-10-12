import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.id,
  });

  factory ProfileModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return ProfileModel(
      id: map['id'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }
}