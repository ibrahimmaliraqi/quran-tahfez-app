part of 'get_students_cubit.dart';

@immutable
sealed class GetStudentsState {}

final class GetStudentsInitial extends GetStudentsState {}

final class GetStudentsLoading extends GetStudentsState {}

final class GetStudentsSuccess extends GetStudentsState {
  final List<StudentEntity> students;

  GetStudentsSuccess({required this.students});
}

final class GetStudentsFailure extends GetStudentsState {
  final String message;

  GetStudentsFailure({required this.message});
}
