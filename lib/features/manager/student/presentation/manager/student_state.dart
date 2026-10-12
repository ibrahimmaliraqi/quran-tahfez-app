part of 'student_cubit.dart';

sealed class StudentState {}

final class StudentInitial extends StudentState {}

final class StudentLoading extends StudentState {}

final class StudentSuccess extends StudentState {}

final class StudentFailure extends StudentState {
  final String message;

  StudentFailure({
    required this.message,
  });
}