part of 'chat_bloc_bloc.dart';

@immutable
sealed class ChatBlocEvent {}

class GetResponseForQueryEvent extends ChatBlocEvent {}

class SendMessageEvent extends ChatBlocEvent {
  final String message;
  SendMessageEvent({required this.message});

  @override
  List<Object?> get props => [message];
}
