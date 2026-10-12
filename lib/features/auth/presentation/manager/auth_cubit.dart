import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
      : super(AuthInitial());

  Future<void> getAuth() async {
    emit(AuthLoading());

    try {
      emit(AuthSuccess());
    } catch (e) {
      emit(
        AuthFailure(
          message: e.toString(),
        ),
      );
    }
  }
}