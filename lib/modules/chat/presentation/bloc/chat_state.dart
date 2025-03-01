part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatBlocInitial extends ChatState {}

class GetResponseForQuerySuccessState extends ChatState {
  final List<ChatEntity> chats;

  GetResponseForQuerySuccessState({this.chats = const []});
}

abstract class GetResponseForQueryActionStates
    extends GetResponseForQuerySuccessState {
  GetResponseForQueryActionStates({super.chats});
}

class GetResponseForQueryLoadingState extends GetResponseForQueryActionStates {
  GetResponseForQueryLoadingState({super.chats});
}

class GetResponseForQueryFailureState extends GetResponseForQueryActionStates {
  GetResponseForQueryFailureState({super.chats});
}
