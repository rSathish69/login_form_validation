import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    log(change.toString());
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    log(transition.toString());
  }

  void _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final email = event.email;
      final password = event.passsword;

      if (password.length < 6) {
        return emit(AuthFailure(errorMessage: "Password should above 6"));
      }

      await Future.delayed(
        const Duration(seconds: 1),
        () {
          return emit(AuthSuccess(uid: "$email-$password"));
        },
      );
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }

  void _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await Future.delayed(
        const Duration(seconds: 1),
        () {
          return emit(AuthInitial());
        },
      );
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }
}
