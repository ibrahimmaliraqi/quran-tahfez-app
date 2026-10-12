import '../../domain/entities/teacher_entity.dart';

class TeacherModel extends TeacherEntity {
  TeacherModel({
    required super.id,
  });

  factory TeacherModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return TeacherModel(
      id: map['id'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }
}