import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_tahfez/core/service/server_locator.dart';
import 'package:quran_tahfez/features/auth/domain/repositories/auth_repo.dart';
import 'package:quran_tahfez/features/auth/presentation/manager/login/login_cubit.dart';
import 'package:quran_tahfez/features/auth/presentation/widgets/login_view_body.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(authRepo: getIt.get<AuthRepo>()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8F5),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: LoginViewBody(),
        ),
      ),
    );
  }
}
