part of 'chat_bloc_bloc.dart';

@immutable
sealed class ChatBlocState {}

final class ChatBlocInitial extends ChatBlocState {}

class GetResponseForQuerySuccessState extends ChatBlocState {
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
