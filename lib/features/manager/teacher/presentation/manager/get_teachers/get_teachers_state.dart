part of 'get_teachers_cubit.dart';

@immutable
sealed class GetTeachersState {}

final class GetTeachersInitial extends GetTeachersState {}

final class GetTeachersLoading extends GetTeachersState {}

final class GetTeachersSuccess extends GetTeachersState {
  final List<TeacherEntity> teachers;

  GetTeachersSuccess({required this.teachers});
}

final class GetTeachersFailure extends GetTeachersState {
  final String errMessage;

  GetTeachersFailure({required this.errMessage});
}
