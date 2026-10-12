part of 'dashboard_cubit.dart';

sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState {}

final class DashboardSuccess extends DashboardState {}

final class DashboardFailure extends DashboardState {
  final String message;

  DashboardFailure({
    required this.message,
  });
}