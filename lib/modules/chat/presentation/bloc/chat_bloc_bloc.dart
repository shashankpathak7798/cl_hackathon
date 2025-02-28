import 'dart:async';

import 'package:cl_hackathon/modules/chat/data/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cl_hackathon/data_state.dart';
import 'package:cl_hackathon/modules/chat/domain/usecases/chat_use_case.dart';
import 'package:meta/meta.dart';

part 'chat_bloc_event.dart';
part 'chat_bloc_state.dart';

class ChatBlocBloc extends Bloc<ChatBlocEvent, ChatBlocState> {
  final TextEditingController msgcontroller = TextEditingController();
  final List<Message> _messages = [];

  ChatBlocBloc() : super(ChatBlocInitial()) {
    on<ChatBlocEvent>((event, emit) {});

    on<GetResponseForQueryEvent>(_onGetResponseForQueryEvent);
    on<SendMessageEvent>(_onSendMessageEvent);
  }

  FutureOr<void> _onGetResponseForQueryEvent(
      GetResponseForQueryEvent event, Emitter<ChatBlocState> emit) async {
    try {
      emit(GetResponseForQueryLoadingState());

      final response = await ChatUseCase().getResponse();

      if (response is DataSuccess) {
        emit(GetResponseForQuerySuccessState());
      } else {
        emit(GetResponseForQueryFailureState());
      }
    } catch (e) {
      emit(GetResponseForQueryFailureState());
    }
  }

  FutureOr<void> _onSendMessageEvent(
      SendMessageEvent event, Emitter<ChatBlocState> emit) async {
    _messages.add(Message(text: event.message, isUser: true));
    const botResponse = "This is a static response from the bot.";
    _messages.add(Message(text: botResponse, isUser: false));
    emit(ChatBotLoaded(messages: List.from(_messages)));
  }
}
