import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'logic/calendar_cubit/calendar_cubit.dart';

import 'core/data/repositories/task_repo_impl.dart';
import 'core/routes/bloc_observer.dart';
import 'core/service/auth_service.dart';
import 'core/service/storage_service.dart';
import 'core/values/constants.dart';
import 'domain/entities/user_entity.dart';
import 'domain/repositories/task_repo.dart';
import 'firebase_options.dart';
import 'logic/auth_bloc/auth_bloc.dart';
import 'logic/localization_bloc/localization_bloc.dart';
import 'logic/navigation_cubit/navigation_cubit.dart';
import 'logic/task_bloc/task_bloc.dart';
import 'logic/theme_mode_cubit/theme_mode_cubit.dart';

final getIt = GetIt.instance;

class Global {
  Global._();

  static late StorageService storageService;
  static late AuthService authService;
  static UserEntity? currentUserData;

  static Future<void> loadCurrentUserData({isNew = false}) async {
    if (isNew) {
      final uid = authService.currentUser!.uid;
      final doc = await FirebaseFirestore.instance
          .collection(AppConstants.FIREBASE_COLLECTION_USERS)
          .doc(uid)
          .get();
      final data = doc.data();

      storageService.setMap(AppConstants.STORAGE_USER_DATA, data ?? {});

      currentUserData = UserEntity.fromMap(data!);
    } else {
      currentUserData = storageService.getUserData;
    }
  }

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();

    Bloc.observer = MyGlobalObseerver();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    storageService = await StorageService().init();
    authService = AuthService();

    _setupGetIt();
  }

  static void _setupGetIt() {
    // Register Core Services
    getIt.registerLazySingleton<StorageService>(() => storageService);
    getIt.registerLazySingleton<AuthService>(() => authService);

    // Register Repositories
    getIt.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl());

    // Register BLoCs
    // getIt.registerFactory<TaskBloc>(() => TaskBloc(getIt<TaskRepository>()));
    getIt.registerLazySingleton<TaskBloc>(
      () => TaskBloc(getIt<TaskRepository>()),
    );

    getIt.registerFactory<LocalizationBloc>(() => LocalizationBloc());
    getIt.registerFactory<NavigationCubit>(() => NavigationCubit());
    getIt.registerFactory<ThemeModeCubit>(() => ThemeModeCubit());
    getIt.registerFactory<CalendarCubit>(() => CalendarCubit());
    getIt.registerFactory<AuthBloc>(
      () => AuthBloc(authService: getIt<AuthService>()),
    );
  }
}
