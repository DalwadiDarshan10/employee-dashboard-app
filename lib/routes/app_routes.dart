import 'package:get/get.dart';
import 'name_routes.dart';
import '../features/splash/screens/splash_screen.dart';
import '../features/splash/bindings/splash_binding.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/dashboard/screens/dashboard_screen.dart';
import '../features/dashboard/bindings/dashboard_binding.dart';

class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(
      name: NameRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: NameRoutes.login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: NameRoutes.dashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
    ),
  ];
}
