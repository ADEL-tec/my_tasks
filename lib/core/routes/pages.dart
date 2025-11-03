import 'package:flutter/material.dart';
import '../../presentation/screens/calendar/tasks_calendar_page.dart';
import '../../presentation/screens/profile/edit_profile.dart';

import '../../presentation/screens/add_edit_task/add_edit_task_page.dart';
import '../../presentation/screens/auth_wrapper.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/login/login_page.dart';
import '../../presentation/screens/profile/profile_page.dart';
import '../../presentation/screens/register/register_page.dart';
import '../../presentation/screens/task_list/task_list_page.dart';
import 'names.dart';

class AppPages {
  static final List<PageEntity> _routes = [
    PageEntity(route: AppRoutes.splashScreen, page: AuthWrapper()),
    PageEntity(route: AppRoutes.home, page: HomeScreen()),
    PageEntity(route: AppRoutes.login, page: LoginPage()),
    PageEntity(route: AppRoutes.signup, page: RegisterPage()),
    PageEntity(route: AppRoutes.profile, page: ProfilePage()),
    PageEntity(route: AppRoutes.tasks, page: TaskListPage()),
    PageEntity(route: AppRoutes.addTask, page: AddEditTaskPage()),
    PageEntity(route: AppRoutes.editTask, page: AddEditTaskPage()),
    PageEntity(route: AppRoutes.editProfile, page: EditProfile()),
    PageEntity(route: AppRoutes.calendar, page: TasksCalendarPage()),
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
      case AppRoutes.signup:
        final page = _getPage(AppRoutes.signup);
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
      case AppRoutes.tasks:
        final page = _getPage(AppRoutes.tasks);
        return MaterialPageRoute(
          builder: (context) => page,
          settings: settings,
        );
      case AppRoutes.addTask:
        final page = _getPage(AppRoutes.addTask);
        return MaterialPageRoute(
          builder: (context) => page,
          settings: settings,
        );
      case AppRoutes.editTask:
        final page = _getPage(AppRoutes.editTask);
        return MaterialPageRoute(
          builder: (context) => page,
          settings: settings,
        );
      case AppRoutes.editProfile:
        final page = _getPage(AppRoutes.editProfile);
        return MaterialPageRoute(
          builder: (context) => page,
          settings: settings,
        );
      case AppRoutes.calendar:
        final page = _getPage(AppRoutes.calendar);
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
