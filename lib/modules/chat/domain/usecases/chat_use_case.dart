import 'package:cl_hackathon/data_state.dart';
import 'package:cl_hackathon/modules/chat/data/repositories/chat_repo_impl.dart';
import 'package:cl_hackathon/modules/chat/domain/entities/chat_entity.dart';

class ChatUseCase {
  Future<DataState<ChatEntity>> getResponse({String? query}) async {
    return await ChatRepoImpl().getResponse(query: query);
  }
}
