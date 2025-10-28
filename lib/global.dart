import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_tasks/core/service/auth_service.dart';

import 'core/routes/bloc_observer.dart';
import 'core/service/storage_service.dart';
import 'firebase_options.dart';

class Global {
  Global._();
  static late StorageService storageService;
  static late AuthService authService;
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();

    Bloc.observer = MyGlobalObseerver();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    storageService = await StorageService().init();
    authService = AuthService();
  }
}
