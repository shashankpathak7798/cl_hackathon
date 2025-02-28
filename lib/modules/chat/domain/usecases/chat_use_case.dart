import 'package:cl_hackathon/data_state.dart';
import 'package:cl_hackathon/modules/chat/data/repositories/chat_repo_impl.dart';

class ChatUseCase {
  Future<DataState> getResponse({String? query}) async {
    return await ChatRepoImpl().getResponse(query: query);
  }
}
