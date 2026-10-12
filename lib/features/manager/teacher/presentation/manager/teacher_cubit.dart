import 'package:flutter_bloc/flutter_bloc.dart';

part 'teacher_state.dart';

class TeacherCubit extends Cubit<TeacherState> {
  TeacherCubit()
      : super(TeacherInitial());

  Future<void> getTeacher() async {
    emit(TeacherLoading());

    try {
      emit(TeacherSuccess());
    } catch (e) {
      emit(
        TeacherFailure(
          message: e.toString(),
        ),
      );
    }
  }
}