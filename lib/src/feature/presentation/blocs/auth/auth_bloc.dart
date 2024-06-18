import 'dart:async';
import 'dart:developer';

import 'package:chat_app_using_socket/src/feature/domain/entities/user_entity.dart';
import 'package:chat_app_using_socket/src/feature/domain/use_cases/auth/sign_in_usecase.dart';
import 'package:chat_app_using_socket/src/feature/domain/use_cases/auth/sign_up_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUsecase signInUsecase;
  final SignUpUsecase signUpUsecase;

  AuthBloc({
    required this.signInUsecase,
    required this.signUpUsecase,
  }) : super(AuthInitial()) {
    on<SignUpEvent>(signUpEvent);
    on<SignInEvent>(signInEvent);
  }

  FutureOr<void> signUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(SignUpLoadingState());
    log('Sign Up Loading');
    try {
      await signUpUsecase.call(event.user);
      log('Sign Up Success');
      emit(SignUpSuccessState());
    } catch (e) {
      emit(SignUpErrorState());
    }
  }

  FutureOr<void> signInEvent(SignInEvent event, Emitter<AuthState> emit) async {
    emit(SignInLoadingState());
    try {
      await signInUsecase.call(event.user);
      log('Sign In Success');
      emit(SignInSuccessState());
    } catch (e) {
      emit(SignInErrorState());
    }
  }
}
