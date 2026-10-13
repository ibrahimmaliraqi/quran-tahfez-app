part of 'delete_teacher_cubit.dart';

@immutable
sealed class DeleteTeacherState {}

final class DeleteTeacherInitial extends DeleteTeacherState {}

final class DeleteTeacherLoading extends DeleteTeacherState {}

final class DeleteTeacherSuccess extends DeleteTeacherState {
  final String message;

  DeleteTeacherSuccess({
    required this.message,
  });
}

final class DeleteTeacherFailure extends DeleteTeacherState {
  final String errMessage;

  DeleteTeacherFailure({
    required this.errMessage,
  });
}
