part of 'teacher_cubit.dart';

sealed class TeacherState {}

final class TeacherInitial extends TeacherState {}

final class TeacherLoading extends TeacherState {}

final class TeacherSuccess extends TeacherState {}

final class TeacherFailure extends TeacherState {
  final String message;

  TeacherFailure({
    required this.message,
  });
}