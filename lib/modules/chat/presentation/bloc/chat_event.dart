part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class GetResponseForQueryEvent extends ChatEvent {
  final bool? isTryAgain;

  GetResponseForQueryEvent({this.isTryAgain});
}
