import 'package:flutter_bloc/flutter_bloc.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  StudentCubit()
      : super(StudentInitial());

  Future<void> getStudent() async {
    emit(StudentLoading());

    try {
      emit(StudentSuccess());
    } catch (e) {
      emit(
        StudentFailure(
          message: e.toString(),
        ),
      );
    }
  }
}