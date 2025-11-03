import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/extensions/context_extensions.dart';

import '../../logic/navigation_cubit/navigation_cubit.dart';

class CostumBottomNavbar extends StatelessWidget {
  const CostumBottomNavbar(this.currentIndex, {super.key});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: context.read<NavigationCubit>().state.selectedIndex,
      onDestinationSelected: (int index) {
        if (index != currentIndex) {
          context.read<NavigationCubit>().setPageIndex(index);
          Navigator.pushNamedAndRemoveUntil(
            context,
            context.read<NavigationCubit>().state.getRouteName,
            (route) => false,
          );
        }
      },
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.home_filled),
          label: context.localization.home,
        ),
        NavigationDestination(
          icon: Icon(Icons.assignment),
          label: context.localization.tasks,
        ),
        NavigationDestination(
          icon: Icon(Icons.calendar_month_rounded),
          label: "Booking",
        ),
        NavigationDestination(
          icon: Icon(Icons.person),
          label: context.localization.profile,
        ),
      ],
    );
  }
}
