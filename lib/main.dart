import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/extensions/context_extensions.dart';
import 'l10n/l10n.dart';
import 'logic/localization_bloc/localization_bloc.dart';
import 'logic/navigation_cubit/navigation_cubit.dart';
import 'logic/task_bloc/task_bloc.dart';
import 'logic/theme_mode_cubit/theme_mode_cubit.dart';

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
        BlocProvider(create: (_) => getIt<LocalizationBloc>()),
        BlocProvider(create: (_) => getIt<AuthBloc>()),
        BlocProvider(create: (_) => getIt<ThemeModeCubit>()),
        BlocProvider(create: (_) => getIt<NavigationCubit>()),
        BlocProvider(create: (context) => getIt<TaskBloc>()),
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
                      title: Text(context.localization.exit),
                      content: Text(context.localization.doYouSureWantLeaveApp),
                      actions: [
                        TextButton(
                          onPressed: () => exit(0),
                          child: Text(context.localization.exit),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: Text(context.localization.cancel),
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
