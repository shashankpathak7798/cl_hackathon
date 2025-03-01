import 'package:cl_hackathon/modules/chat/data/models/get_response_for_query_response_model.dart';
import 'package:cl_hackathon/modules/chat/domain/entities/chat_entity.dart';
import 'package:cl_hackathon/modules/chat/presentation/bloc/chat_bloc_bloc.dart';
import 'package:cl_hackathon/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.chatEntity, required this.isLast});

  final ChatEntity chatEntity;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBlocBloc, ChatBlocState>(
      builder: (context, state) {
        final isLoading = state is GetResponseForQueryLoadingState;
        return Align(
          alignment:
              chatEntity.isBot ? Alignment.centerLeft : Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11.5),
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: chatEntity.isBot
                ? null
                : BoxDecoration(
                    color: Color(0xFF3D2D4C),
                    borderRadius: BorderRadius.circular(30),
                  ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (chatEntity.isBot) ...{
                      Image.asset(
                        "assets/images/bot_response.png",
                        width: 48,
                        height: 49,
                      ),
                      UIHelpers.horizontalSpace(24),
                    },
                    if (isLoading && isLast) ...{
                      LoadingAnimationWidget.waveDots(
                        color: Color(0xFF3D2D4C),
                        size: 40,
                      )
                    } else ...{
                      Flexible(
                        child: Text(
                          chatEntity.explanation,
                          style: chatEntity.isBot
                              ? GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: Color(0xFF3D2D4C),
                                )
                              : GoogleFonts.roboto(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                      if (chatEntity.isError) ...{
                        UIHelpers.horizontalSpaceTiny,
                        Flexible(
                          child: InkWell(
                            onTap: () => BlocProvider.of<ChatBlocBloc>(context)
                                .add(GetResponseForQueryEvent(
                              isTryAgain: true,
                            )),
                            child: Text(
                              "Click Here",
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      },
                    }
                  ],
                ),
                if (chatEntity.results != null &&
                    chatEntity.results?.isNotEmpty == true) ...{
                  UIHelpers.verticalSpaceSmall,
                  _buildTable(chatEntity.results ?? []),
                }
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTable(List<Result> results) {
    if (results.isEmpty) return const SizedBox.shrink();

    // Extract column names dynamically
    List<String> columnNames = [
      "Emp Id",
      "Employee Name",
      "Gender",
      "Date Of Joining",
      "Designation",
      "Task",
      "Task Priority",
    ];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.7,
          color: Colors.black38,
        ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: columnNames
              .map((column) => DataColumn(label: Text(column)))
              .toList(),
          rows: results.map((rowData) {
            return DataRow(
              cells: rowData.props.map((item) {
                return DataCell(Text(item?.toString() ?? ''));
              }).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }
}
