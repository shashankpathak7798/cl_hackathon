import 'package:cl_hackathon/modules/chat/data/models/get_response_for_query_response_model.dart';

class ChatEntity {
  final String explanation;
  final List<Result>? results;
  final bool isBot;
  final bool isError;

  ChatEntity(
      {required this.explanation,
      this.isBot = false,
      this.isError = false,
      this.results});
}
