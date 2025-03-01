import 'dart:async';

import 'package:cl_hackathon/modules/chat/domain/entities/chat_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cl_hackathon/data_state.dart';
import 'package:cl_hackathon/modules/chat/domain/usecases/chat_use_case.dart';
import 'package:meta/meta.dart';

part 'chat_bloc_event.dart';
part 'chat_bloc_state.dart';

class ChatBlocBloc extends Bloc<ChatBlocEvent, ChatBlocState> {
  final TextEditingController msgcontroller = TextEditingController();

  ChatBlocBloc() : super(ChatBlocInitial()) {
    on<ChatBlocEvent>((event, emit) {});

    on<GetResponseForQueryEvent>(_onGetResponseForQueryEvent);
  }

  final TextEditingController queryController = TextEditingController();

  List<ChatEntity> chats = [];

  FutureOr<void> _onGetResponseForQueryEvent(
      GetResponseForQueryEvent event, Emitter<ChatBlocState> emit) async {
    try {
      if (event.isTryAgain == true) {
        chats.removeLast();
      } else {
        chats.add(ChatEntity(
          explanation: queryController.text,
        ));
      }

      chats.add(ChatEntity(
        explanation: "",
        isBot: true,
      ));

      emit(GetResponseForQueryLoadingState(
        chats: chats,
      ));

      final response =
          await ChatUseCase().getResponse(query: queryController.text);
      queryController.clear();
      if (response is DataSuccess<ChatEntity>) {
        if (response.data == null) {
          chats.removeLast();
          chats.add(ChatEntity(
            explanation: "Oops! Something went wrong! Try again",
            isError: true,
            isBot: true,
          ));
          emit(GetResponseForQuerySuccessState(
            chats: chats,
          ));
        } else {
          chats.removeLast();
          chats.add(response.data ??
              ChatEntity(
                explanation: "Oops! Something went wrong! Try again",
                isBot: true,
                isError: true,
              ));
          emit(GetResponseForQuerySuccessState(
            chats: chats,
          ));
        }
      } else {
        chats.removeLast();
        chats.add(ChatEntity(
            explanation: "Oops! Something went wrong! Try again",
            isError: true,
            isBot: true));
        emit(GetResponseForQueryFailureState(
          chats: chats,
        ));
      }
    } catch (e) {
      chats.removeLast();
      chats.add(ChatEntity(
        explanation: "Oops! Something went wrong! Try again",
        isError: true,
        isBot: true,
      ));
      emit(GetResponseForQueryFailureState(
        chats: chats,
      ));
    }
  }
}
