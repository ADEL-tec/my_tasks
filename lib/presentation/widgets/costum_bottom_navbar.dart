import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/navigation_cubit/cubit/navigation_cubit.dart';

class CostumBottomNavbar extends StatelessWidget {
  const CostumBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    print(context.read<NavigationCubit>().state.selectedIndex);
    return NavigationBar(
      selectedIndex: context.read<NavigationCubit>().state.selectedIndex,
      onDestinationSelected: (int index) {
        print("clicked=> $index");
        context.read<NavigationCubit>().setPageIndex(index);
        Navigator.pushNamedAndRemoveUntil(
          context,
          context.read<NavigationCubit>().state.getRouteName,
          (route) => false,
        );
      },
      destinations: [
        NavigationDestination(icon: Icon(Icons.home_filled), label: "Home"),
        NavigationDestination(
          icon: Icon(Icons.calendar_month_rounded),
          label: "Booking",
        ),
        NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
