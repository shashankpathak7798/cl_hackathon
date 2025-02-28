import 'package:cl_hackathon/data_error.dart';
import 'package:cl_hackathon/data_state.dart';
import 'package:cl_hackathon/modules/chat/domain/repositories/chat_repository.dart';

class ChatRepoImpl extends ChatRepository {
  @override
  Future<DataState> getResponse({String? query}) async {
    try {
      return DataSuccess({
        "response": {
          "query": query,
          "res": "HELLO THERE!!",
        }
      });
    } catch (e) {
      return DataFailure(DataError());
    }
  }
}
