import 'package:go_router/go_router.dart';
import 'package:quran_tahfez/features/auth/presentation/view/login_view.dart';
import 'package:quran_tahfez/features/manager/dashboard/presentation/view/manager_dashboard_view.dart';
import 'package:quran_tahfez/splash_view.dart';

class AppRouter {
  static const splashView = '/';
  static const login = '/login';
  static const managerDashboardView = '/managerDashboardView';
  // static const register = '/register';
  // static const productView = '/productView';
  // static const cartView = '/cartView';
  // static const editPrefileView = '/editPrefileView';
  // static const prefileView = '/prefileView';
  // static const orderDetailsView = '/orderDetailsView';
  // static const productsByCategoryView = '/productsByCategoryView';
  // static const searchView = '/searchView';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: splashView,
        builder: (context, state) => SplashView(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => LoginView(),
      ),
      GoRoute(
        path: managerDashboardView,
        builder: (context, state) => ManagerDashboardView(),
      ),
    ],
  );
}
