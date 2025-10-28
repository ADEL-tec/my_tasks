import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_tasks/core/extensions/context_extensions.dart';
import 'package:my_tasks/logic/localization_bloc/localization_bloc.dart';
import 'package:my_tasks/logic/theme_mode_cubit/theme_mode_cubit.dart';

import '../widgets/costum_bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ThemeMode _selectedOption;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeCubit, ThemeModeState>(
      builder: (context, state) {
        _selectedOption = state.themeMode;
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Text(context.localization.appName),
                  ElevatedButton(
                    onPressed: () {
                      if (BlocProvider.of<LocalizationBloc>(
                            context,
                          ).state.locale ==
                          "ar") {
                        context.read<LocalizationBloc>().add(
                          OnLocalizationEnglishEvent(),
                        );
                      } else {
                        context.read<LocalizationBloc>().add(
                          OnLocalizationArabicEvent(),
                        );
                      }
                    },
                    child: Text('change Language'),
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedOption
                        .name, // Your state variable for the selected value
                    items: <String>['dark', 'light', 'system']
                        .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        })
                        .toList(),
                    onChanged: (String? newValue) {
                      context.read<ThemeModeCubit>().setTheme(
                        ThemeMode.values.byName(newValue!),
                      );
                    },
                    decoration: InputDecoration(
                      labelText: 'Select an option',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: CostumBottomNavbar(),
        );
      },
    );
  }
}
