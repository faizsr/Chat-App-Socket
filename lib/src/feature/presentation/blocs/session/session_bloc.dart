import 'dart:async';
import 'dart:developer';

import 'package:chat_app_using_socket/src/feature/data/models/session/session_model.dart';
import 'package:chat_app_using_socket/src/feature/domain/use_cases/session/create_session_usecase.dart';
import 'package:chat_app_using_socket/src/feature/domain/use_cases/session/get_session_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final CreateSessionUsecase createSessionUsecase;
  final GetAllSessionUsecase getAllSessionUsecase;
  SessionBloc({
    required this.createSessionUsecase,
    required this.getAllSessionUsecase,
  }) : super(SessionInitial()) {
    on<CreateSessionEvent>(createSessionEvent);
    on<GetAllSessionEvent>(getSessionEvent);
  }

  FutureOr<void> createSessionEvent(
      CreateSessionEvent event, Emitter<SessionState> emit) async {
    emit(CreateSessionLoadingState());
    try {
      await createSessionUsecase.call(event.id, event.name);
      emit(CreateSessionSuccessState());
    } catch (e) {
      emit(CreateSessionErrorState());
    }
  }

  FutureOr<void> getSessionEvent(
      GetAllSessionEvent event, Emitter<SessionState> emit) async {
    emit(GetAllSessionLoadingState());
    try {
      List<SessionModel> sessions = await getAllSessionUsecase.call();
      log('Sessions list length: ${sessions.length}');
      emit(GetAllSessionSucesssState(sessions: sessions));
    } catch (e) {
      emit(GetAllSessionErrorState());
    }
  }
}
