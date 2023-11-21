import 'package:get/get.dart';
import 'package:rent_flex/pages/contracts_page/controllers/contracts_binding.dart';
import 'package:rent_flex/pages/contracts_page/index.dart';
import 'package:rent_flex/pages/dashboard_page/controllers/dashboard_binding.dart';
import 'package:rent_flex/pages/estates_page/controllers/estates_binding.dart';
import 'package:rent_flex/pages/estates_page/index.dart';
import 'package:rent_flex/pages/login_page/controllers/login_binding.dart';
import 'package:rent_flex/pages/login_page/index.dart';
import 'package:rent_flex/pages/marketplace_page/controllers/marketplace_binding.dart';
import 'package:rent_flex/pages/onboarding_page/controllers/onboarding_binding.dart';
import 'package:rent_flex/pages/profile_page/controllers/profile_binding.dart';
import 'package:rent_flex/pages/transaction_page/controllers/transaction_binding.dart';

import '../pages/dashboard_page/index.dart';
import '../pages/home_page/controllers/home_binding.dart';
import '../pages/home_page/index.dart';
import '../pages/marketplace_page/index.dart';
import '../pages/onboarding_page/index.dart';
import '../pages/profile_page/index.dart';
import '../pages/splash_page/controllers/splash_binding.dart';
import '../pages/splash_page/index.dart';
import '../pages/transaction_page/index.dart';

class AppRouter {
  static var routes = [
    GetPage(
      name: '/',page: () => HomePage(),bindings: [HomeBinding(), DashboardBinding(), TransactionBinding(), MarketplaceBinding(), ProfileBinding()],
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
    GetPage(
        name: "/estates", page: ()=> EstatesPage(), binding: EstatesBinding()
    ),
    GetPage(
        name: "/contracts", page: ()=> ContractsPage(), binding: ContractsBinding()
    ),
    GetPage(
        name: "/dashboard", page: ()=> DashboardPage(), binding: DashboardBinding()
    ),
    GetPage(
        name: "/marketplace", page: ()=> MarketplacePage(), binding: MarketplaceBinding()
    ),
    GetPage(
        name: "/profile", page: ()=> ProfilePage(), binding: ProfileBinding()
    ),
    GetPage(
        name: "/transaction", page: ()=> TransactionPage(), binding: TransactionBinding()
    ),


  ];
}