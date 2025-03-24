import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khazana_fintech_task/core/usecase/usecase.dart';
import 'package:khazana_fintech_task/features/auth/domain/entities/state_entity.dart';
import 'package:khazana_fintech_task/features/auth/domain/entities/user_entity.dart';
import 'package:khazana_fintech_task/features/auth/domain/usecases/current_user.dart';
import 'package:khazana_fintech_task/features/auth/domain/usecases/logout.dart';
import 'package:khazana_fintech_task/features/auth/domain/usecases/user_sign_in.dart';
import 'package:khazana_fintech_task/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final Logout _logout;
  AuthBloc(
      {required UserSignUp userSignUp,
      required UserSignIn userSignIn,
      required Logout logout,
      required CurrentUser currentUser})
      : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _currentUser = currentUser,
        _logout = logout,
        super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) => emit(AuthLoadingState()),
    );
    on<AuthSignUpEvent>(authSignUpEvent);
    on<AuthSignInEvent>(authSignInEvent);
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthUserLoggedOut>(_onLogoutRequested);
  }
  // 🔹 Restore session when app starts
  FutureOr<void> _onAuthCheckRequested(
      AuthCheckRequested event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());
    res.fold((l) => emit(AuthFailureState(l.message)),
        (r) => emit(AuthAuthenticated(user: r)));
  }

  // 🔹 Restore session when app starts
  FutureOr<void> _onLogoutRequested(
      AuthUserLoggedOut event, Emitter<AuthState> emit) async {
    final res = await _logout(NoParams());
    res.fold((l) => emit(AuthFailureState(l.message)),
        (r) => emit(AuthUnauthenticated()));
  }

  FutureOr<void> authSignUpEvent(
      AuthSignUpEvent event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(UserSignUpParms(
      email: event.email,
      name: event.name,
      password: event.password,
    ));
    res.fold((l) => emit(AuthFailureState(l.message)),
        (r) => _emitAuthSuccess(r, emit));
  }

  FutureOr<void> authSignInEvent(
      AuthSignInEvent event, Emitter<AuthState> emit) async {
    final res = await _userSignIn(UserSignInParams(
      email: event.email,
      password: event.password,
    ));
    res.fold((l) => emit(AuthFailureState(l.message)),
        (r) => _emitAuthSuccess(r, emit));
  }

  void _emitAuthSuccess(
    UserEntity userEntity,
    Emitter<AuthState> emit,
  ) {
    emit(AuthSuccessState(userEntity));
  }
}
