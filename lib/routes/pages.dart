import 'package:flutter/material.dart';
import 'package:login_app/routes/routes.dart';
import 'package:login_app/ui/home/home_page.dart';
import 'package:login_app/ui/login/login_page.dart';
import 'package:login_app/ui/signup/register_page.dart';
import 'package:login_app/ui/splash/splash_page.dart';

Map<String, Widget Function(BuildContext context)> appRoutes() {
  return {
    Routes.login: (_) => const LoginPage(),
    Routes.home: (_) => const HomePage(),
    Routes.register: (_) => const RegisterPage(),
    Routes.splash:(_) => const SplashPage(),
  };
}