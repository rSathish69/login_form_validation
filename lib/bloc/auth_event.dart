part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLoginRequested extends AuthEvent {
  final String email;
  final String passsword;

  AuthLoginRequested({
    required this.email,
    required this.passsword,
  });
}

final class AuthLogoutRequested extends AuthEvent {}
