import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<LogoutEvent>(_onLogoutEvent);
  }

  FutureOr<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // In a real app, you would call your authentication API here
      // For demo purposes, we'll just validate and pretend it's successful
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  FutureOr<void> _onLogoutEvent(LogoutEvent event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }
}