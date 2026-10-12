import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit()
      : super(DashboardInitial());

  Future<void> getDashboard() async {
    emit(DashboardLoading());

    try {
      emit(DashboardSuccess());
    } catch (e) {
      emit(
        DashboardFailure(
          message: e.toString(),
        ),
      );
    }
  }
}