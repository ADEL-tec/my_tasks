import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_tasks/l10n/l10n.dart';
import 'package:my_tasks/logic/localization_bloc/localization_bloc.dart';
import 'package:my_tasks/logic/navigation_cubit/cubit/navigation_cubit.dart';
import 'package:my_tasks/logic/theme_mode_cubit/theme_mode_cubit.dart';

import 'core/routes/pages.dart';
import 'core/themes/app_theme.dart';
import 'global.dart';
import 'logic/auth_bloc/auth_bloc.dart';

void main() async {
  await Global.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocalizationBloc()),
        BlocProvider(
          create: (_) =>
              AuthBloc(authService: Global.authService)..add(AppStarted()),
        ),
        BlocProvider(create: (_) => ThemeModeCubit()),
        BlocProvider(create: (_) => NavigationCubit()),
      ],
      child: BlocBuilder<LocalizationBloc, LocalizationState>(
        builder: (context, localizationState) {
          return BlocBuilder<ThemeModeCubit, ThemeModeState>(
            builder: (context, themeState) {
              return PopScope(
                canPop: false,
                onPopInvokedWithResult: (didPop, result) {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Exit'),
                      content: const Text(
                        'Do you sure you want leave the app!',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => exit(0),
                          child: const Text('exit'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('cancel'),
                        ),
                      ],
                    ),
                  );
                },
                child: ScreenUtilInit(
                  designSize: Size(375, 812),
                  builder: (context, child) => MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'My Tasks',

                    // cTheme setup
                    theme: MaterialTheme.light(),
                    darkTheme: MaterialTheme.dark(),
                    themeMode: themeState.themeMode,

                    // Localization setup
                    supportedLocales: AppLocalizations.supportedLocales,
                    locale: Locale(localizationState.locale),
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    initialRoute: "/",
                    onGenerateRoute: AppPages.onGenerateRoute,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
