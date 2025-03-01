import 'package:cl_hackathon/data_state.dart';

abstract class ChatRepository {
  Future<DataState> getResponse({String? query});
}
