import 'package:cl_hackathon/core/network/api_provider.dart';
import 'package:cl_hackathon/core/network/log.dart';
import 'package:cl_hackathon/data_error.dart';
import 'package:cl_hackathon/data_state.dart';
import 'package:cl_hackathon/modules/chat/data/models/get_response_for_query_response_model.dart';
import 'package:cl_hackathon/modules/chat/domain/entities/chat_entity.dart';
import 'package:cl_hackathon/modules/chat/domain/repositories/chat_repository.dart';

class ChatRepoImpl extends ChatRepository {
  final apiProvider = ApiProvider();
  @override
  Future<DataState<ChatEntity>> getResponse({String? query}) async {
    try {
      var headers = <String, String>{};
      headers["Content-Type"] = "application/json";

      await Future.delayed(Duration(seconds: 3));
      final response = await apiProvider.getData(
        url: "/api/Resource/MakePost",
        body: {
          "userQuery": query ?? "",
        },
      );

      if (response == null) {
        return DataFailure(DataError());
      }
      final model = GetResponseForQueryResponseModel.fromJson(response);

      return DataSuccess(
        ChatEntity(
          explanation: model.explaination ?? "",
          isBot: true,
          results: [],
        ),
      );
    } catch (e) {
      Log.error("Caught Exception in getResponse: $e");
      return DataFailure(DataError());
    }
  }
}
