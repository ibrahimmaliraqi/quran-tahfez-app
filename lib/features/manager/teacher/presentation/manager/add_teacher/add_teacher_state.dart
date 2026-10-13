part of 'add_teacher_cubit.dart';

@immutable
sealed class AddTeacherState {}

final class AddTeacherInitial extends AddTeacherState {}

final class AddTeacherLoading extends AddTeacherState {}

final class AddTeacherSuccess extends AddTeacherState {
  final TeacherEntity teachers;

  AddTeacherSuccess({required this.teachers});
}

final class AddTeacherFailure extends AddTeacherState {
  final String errMessage;

  AddTeacherFailure({required this.errMessage});
}
