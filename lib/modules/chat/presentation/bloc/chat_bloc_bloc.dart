import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cl_hackathon/data_state.dart';
import 'package:cl_hackathon/modules/chat/domain/usecases/chat_use_case.dart';
import 'package:meta/meta.dart';

part 'chat_bloc_event.dart';
part 'chat_bloc_state.dart';

class ChatBlocBloc extends Bloc<ChatBlocEvent, ChatBlocState> {
  ChatBlocBloc() : super(ChatBlocInitial()) {
    on<ChatBlocEvent>((event, emit) {});

    on<GetResponseForQueryEvent>(_onGetResponseForQueryEvent);
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
}
