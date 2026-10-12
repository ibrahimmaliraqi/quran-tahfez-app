import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quran_tahfez/features/auth/domain/entities/user_entity.dart';
import 'package:quran_tahfez/features/auth/domain/repositories/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;
  LoginCubit({required this.authRepo}) : super(LoginInitial());
  Future login({required String email, required String password}) async {
    emit(LoginLoading());
    final res = await authRepo.login(email: email, password: password);
    res.fold(
      (l) => emit(LoginFailure(errMessage: l.message)),
      (r) => emit(LoginSuccess(user: r)),
    );
  }
}
