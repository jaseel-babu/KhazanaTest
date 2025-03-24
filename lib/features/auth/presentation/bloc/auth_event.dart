part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUpEvent extends AuthEvent {
  final String email;
  final String name;
  final String password;

  AuthSignUpEvent({
    required this.email,
    required this.name,
    required this.password,
  });
}

final class AuthSignInEvent extends AuthEvent {
  final String email;
  final String password;

  AuthSignInEvent({
    required this.email,
    required this.password,
  });
}


final class AuthUserLoggedOut extends AuthEvent {}
class AuthCheckRequested extends AuthEvent {} // 🔹 Restore session on app start
