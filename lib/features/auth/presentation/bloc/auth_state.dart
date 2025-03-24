part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSuccessState extends AuthState {
  final UserEntity user;

  AuthSuccessState(this.user);
}

final class AuthFailureState extends AuthState {
  final String message;

  AuthFailureState(this.message);
}

class AuthAuthenticated extends AuthState {
   final StateEntity user ;

  AuthAuthenticated({
    required this.user,
  });
} // 🔹 User is logged in

class AuthUnauthenticated extends AuthState {} // 🔹 User is logged out