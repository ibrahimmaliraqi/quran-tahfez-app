part of 'add_student_cubit.dart';

@immutable
sealed class AddStudentState {}

final class AddStudentInitial extends AddStudentState {}

final class AddStudentLoading extends AddStudentState {}

final class AddStudentSuccess extends AddStudentState {
  final StudentEntity student;

  AddStudentSuccess({required this.student});
}

final class AddStudentFailure extends AddStudentState {
  final String errMessage;

  AddStudentFailure({required this.errMessage});
}
