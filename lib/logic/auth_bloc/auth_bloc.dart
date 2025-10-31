import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../core/service/auth_service.dart';
import '../../core/values/constants.dart';
import '../../domain/entities/user_entity.dart';
import '../../global.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc({required this.authService}) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);

    // Checking Auth on creation
    add(AppStarted());
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final savedUid = Global.storageService.getIsLoggedIn;
    final user = authService.currentUser;

    if (user != null && savedUid != null) {
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final userCredential = await authService.signIn(
        email: event.email,
        password: event.password,
      );

      await Global.storageService.setString(
        AppConstants.STORAGE_USER_UID,
        userCredential.user!.uid,
      );
      await Global.loadCurrentUserData();

      emit(Authenticated(userCredential.user!));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Login failed"));
      emit(Unauthenticated(message: e.message));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final userCredential = await authService.createAcount(
        user: event.user,
        password: event.password,
      );

      await Global.storageService.setString(
        AppConstants.STORAGE_USER_UID,
        userCredential.user!.uid,
      );

      await Global.loadCurrentUserData();

      emit(Authenticated(userCredential.user!));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Login Register"));
      emit(Unauthenticated(message: e.message));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await authService.signOut();
    await Global.storageService.remove(AppConstants.STORAGE_USER_UID);
    await Global.storageService.remove(AppConstants.STORAGE_NAVIGATION_INDEX);

    emit(Unauthenticated());
  }
}
