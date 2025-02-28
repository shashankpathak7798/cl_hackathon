part of 'chat_bloc_bloc.dart';

@immutable
sealed class ChatBlocState {}

final class ChatBlocInitial extends ChatBlocState {}

class GetResponseForQueryLoadingState extends ChatBlocState {}

class GetResponseForQueryFailureState extends ChatBlocState {}

class GetResponseForQuerySuccessState extends ChatBlocState {}

class ChatBotLoaded extends ChatBlocState {
  final List<Message>? messages;
  ChatBotLoaded({this.messages});

  @override
  List<Object?> get props => [messages];
}
