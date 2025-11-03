part of 'navigation_cubit.dart';

class NavigationState extends Equatable {
  final int selectedIndex;
  const NavigationState(this.selectedIndex);

  String get getRouteName {
    switch (selectedIndex) {
      case 0:
        return AppRoutes.home;
      case 1:
        return AppRoutes.tasks;
      case 2:
        return AppRoutes.calendar;
      case 3:
        return AppRoutes.profile;
      default:
        return AppRoutes.home;
    }
  }

  @override
  List<Object> get props => [selectedIndex];
}
