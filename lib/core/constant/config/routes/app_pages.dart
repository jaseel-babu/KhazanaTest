import 'package:flutter/material.dart';
import 'package:khazana_fintech_task/core/constant/config/routes/app_routes.dart';
import 'package:khazana_fintech_task/features/auth/presentation/pages/login_page.dart';
import 'package:khazana_fintech_task/features/auth/presentation/pages/signup_page.dart';
import 'package:khazana_fintech_task/features/dashboard/presentation/pages/home_page.dart';

class AppPages {
  static final Map<String, WidgetBuilder> routes = {
    AppRoutes.loginPage: (context) => const LoginPage(),
    AppRoutes.signupPage: (context) => const SignupPage(),
    AppRoutes.homePage: (context) => const HomePage(),
  };
}
