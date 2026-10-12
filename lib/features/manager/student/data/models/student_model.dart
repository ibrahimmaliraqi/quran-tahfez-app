import '../../domain/entities/student_entity.dart';

class StudentModel extends StudentEntity {
  StudentModel({
    required super.id,
  });

  factory StudentModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return StudentModel(
      id: map['id'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }
}