import 'package:get/get.dart';
import 'package:rent_flex/pages/login_page/controllers/login_binding.dart';
import 'package:rent_flex/pages/login_page/index.dart';
import 'package:rent_flex/pages/onboarding_page/controllers/onboarding_binding.dart';

import '../pages/home_page/controllers/home_binding.dart';
import '../pages/home_page/index.dart';
import '../pages/onboarding_page/index.dart';
import '../pages/splash_page/controllers/splash_binding.dart';
import '../pages/splash_page/index.dart';

class AppRouter {
  static var routes = [
    GetPage(
      name: '/',page: () => HomePage(),binding: HomeBinding(),
    ),
    GetPage(
      name: '/splash',page: () => SplashPage(),binding: SplashBinding(),
    ),
    GetPage(
        name: "/onboarding", page: () => OnboardingPage(), binding: OnboardingBinding()
    ),
    GetPage(
        name: "/login", page: () => LoginPage(), binding: LoginBinding()
    ),

  ];
}