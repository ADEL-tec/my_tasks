import 'package:flutter/material.dart';
import 'package:my_tasks/presentation/screens/auth_wrapper.dart';
import 'package:my_tasks/presentation/screens/login/login_page.dart';
import 'package:my_tasks/presentation/screens/profile/profile_page.dart';

import '../../presentation/screens/home_screen.dart';
import 'names.dart';

class AppPages {
  static final List<PageEntity> _routes = [
    PageEntity(route: AppRoutes.splashScreen, page: AuthWrapper()),
    PageEntity(route: AppRoutes.home, page: HomeScreen()),
    PageEntity(route: AppRoutes.login, page: LoginPage()),
    PageEntity(route: AppRoutes.profile, page: ProfilePage()),
  ];

  static List<dynamic> get allBLocBroviders =>
      _routes.map((e) => e.bloc).toList();

  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        final page = _getPage(AppRoutes.splashScreen);
        return MaterialPageRoute(
          builder: (context) => page,
          settings: settings,
        );
      case AppRoutes.home:
        final page = _getPage(AppRoutes.home);
        return MaterialPageRoute(
          builder: (context) => page,
          settings: settings,
        );
      case AppRoutes.login:
        final page = _getPage(AppRoutes.login);
        return MaterialPageRoute(
          builder: (context) => page,
          settings: settings,
        );
      case AppRoutes.profile:
        final page = _getPage(AppRoutes.profile);
        return MaterialPageRoute(
          builder: (context) => page,
          settings: settings,
        );

      default:
        final page = _getPage(AppRoutes.home);
        return MaterialPageRoute(
          builder: (context) => page,
          settings: settings,
        );
    }
  }

  static _getPage(String page) =>
      _routes.firstWhere((e) => e.route == page).page;
}

class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({required this.route, required this.page, this.bloc});
}
