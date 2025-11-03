import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/context_extensions.dart';
import '../../../core/routes/names.dart';
import '../../../core/values/values.dart';
import '../../../l10n/l10n.dart';
import '../../../logic/localization_bloc/localization_bloc.dart';
import '../../../logic/theme_mode_cubit/theme_mode_cubit.dart';
import '../../widgets/costum_bottom_navbar.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/my_button.dart';
import 'profile_controller.dart';
import 'widgets/profile_image_container.dart';
import 'widgets/settings_dropdown.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<LocalizationBloc>().state.locale;
    context.read<ThemeModeCubit>().state.themeMode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            DefaultAppBar(
              title: context.localization.profile,
              actionIcon: Icons.edit_square,
              onClickAction: () {
                Navigator.pushNamed(context, AppRoutes.editProfile);
              },
            ),
            ProfileImageContainer(),
            SizedBox(height: 10.h),
            Text(
              context.localization.name,
              style: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Container(
                padding: EdgeInsetsDirectional.only(
                  top: Values.horizontalPadding,
                  end: Values.horizontalPadding,
                  start: Values.horizontalPadding,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadiusDirectional.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                width: double.infinity,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text(
                      context.localization.settings,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    SettingsDropdown<String>(
                      label: context.localization.language,
                      value: context.watch<LocalizationBloc>().state.locale,
                      options: AppLocalizations.supportedLocales
                          .map((e) => e.languageCode.toString())
                          .toList(),
                      textBuilder: (langCode) =>
                          ProfileController.getLanguageName(context, langCode),
                      iconBuilder: (langCode) => Icons.language,
                      onChanged: (newLang) =>
                          ProfileController.onLanguageChange(context, newLang),
                    ),
                    SettingsDropdown<String>(
                      label: context.localization.themeMode,
                      value: context
                          .watch<ThemeModeCubit>()
                          .state
                          .themeMode
                          .name,
                      options: ['dark', 'light', 'system'],
                      textBuilder: (value) =>
                          ProfileController.getThemeModeName(context, value),
                      iconBuilder: ProfileController.getThemeModeIcon,
                      onChanged: (newValue) =>
                          ProfileController.onThemeModeChange(
                            context,
                            newValue,
                          ),
                    ),
                    MyButton(
                      btnType: ButtonType.primary,
                      text: context.localization.logOut,
                      onTap: () => ProfileController.onLogout(context),
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
