import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/routes/routes.dart';
import '../../logic/navigation_cubit/navigation_cubit.dart';

import '../../logic/auth_bloc/auth_bloc.dart';
import 'splash_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      listener: (context, state) {
        Future.delayed(Duration(seconds: 2), () {
          if (state is Authenticated) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              context.read<NavigationCubit>().state.getRouteName,
              (route) => false,
            );
          } else if (state is Unauthenticated) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.login,
              (route) => false,
            );
          }
        });
      },
      child: const SplashScreen(),
    );
  }
}
