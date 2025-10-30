import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../global.dart';
import '../../../logic/navigation_cubit/navigation_cubit.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/routes/routes.dart';

import '../../../logic/auth_bloc/auth_bloc.dart';
import '../../../logic/localization_bloc/localization_bloc.dart';
import '../../../logic/theme_mode_cubit/theme_mode_cubit.dart';
import '../../widgets/costum_bottom_navbar.dart';
import '../../widgets/default_app_bar.dart';
import 'widgets/my_list_tile.dart';
import 'widgets/settings_dropdown.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ThemeMode _selectedOption;

  late String _selectedLocalOption;

  @override
  void initState() {
    super.initState();
    _selectedLocalOption = context.read<LocalizationBloc>().state.locale;

    _selectedOption = context.read<ThemeModeCubit>().state.themeMode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            DefaultAppBar(title: "profile"),
            Container(
              width: 100.h,
              height: 100.h,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  "A",
                  style: TextStyle(
                    fontSize: 49.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Name",
              style: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "setting",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    SettingsDropdown<String>(
                      label: 'Language',
                      value: _selectedLocalOption,
                      options: ['en', 'ar'],
                      textBuilder: (langCode) =>
                          {'en': 'English', 'ar': 'العربية'}[langCode]!,
                      iconBuilder: (langCode) => Icons.language,
                      onChanged: (newLang) {
                        if (newLang == 'ar') {
                          context.read<LocalizationBloc>().add(
                            OnLocalizationArabicEvent(),
                          );
                        } else {
                          context.read<LocalizationBloc>().add(
                            OnLocalizationEnglishEvent(),
                          );
                        }
                      },
                    ),
                    SettingsDropdown<String>(
                      label: 'Theme Mode',
                      value: _selectedOption.name,
                      options: ['dark', 'light', 'system'],
                      textBuilder: (value) =>
                          value[0].toUpperCase() + value.substring(1),
                      iconBuilder: (value) {
                        switch (value) {
                          case 'dark':
                            return Icons.dark_mode;
                          case 'light':
                            return Icons.light_mode;
                          case 'system':
                            return Icons.brightness_auto;
                          default:
                            return Icons.settings;
                        }
                      },
                      onChanged: (newValue) {
                        context.read<ThemeModeCubit>().setTheme(
                          ThemeMode.values.byName(newValue!),
                        );
                      },
                    ), //
                    Spacer(),
                    FilledButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(LogoutRequested());
                        context.read<NavigationCubit>().setPageIndex(0);

                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.login,
                          ModalRoute.withName('/'),
                        );
                      },
                      child: Text("logout"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CostumBottomNavbar(3),
    );
  }
}
