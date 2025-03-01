import 'package:cl_hackathon/modules/chat/presentation/bloc/chat_bloc.dart';
import 'package:cl_hackathon/modules/chat/presentation/widgets/chats_widget.dart';
import 'package:cl_hackathon/responsive.dart';
import 'package:cl_hackathon/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final queryFieldFocusNode = FocusNode();

  @override
  void initState() {
    queryFieldFocusNode.addListener(
      () {
        if (!queryFieldFocusNode.hasFocus) {
          if (!queryFieldFocusNode.hasFocus) {
            queryFieldFocusNode.requestFocus();
          }
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Form(
          key: BlocProvider.of<ChatBloc>(context).formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 70,
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "CentraGPT",
                      style: GoogleFonts.ibmPlexMono(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    VerticalDivider(
                      color: Colors.black,
                    ),
                    Text(
                      "New Chat",
                      style: GoogleFonts.ibmPlexMono(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          letterSpacing: -0.5),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: UIHelpers.screenWidth(context),
                  height: UIHelpers.screenHeight(context) - 70,
                  margin: EdgeInsets.symmetric(horizontal: 71),
                  decoration: BoxDecoration(color: Colors.white),
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.isMobile(context) ? 40 : 100,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (BlocProvider.of<ChatBloc>(context)
                          .chats
                          .isNotEmpty) ...{
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 68,
                          ),
                          child: ChatsWidget(),
                        ),
                        Spacer(),
                      } else ...{
                        Text(
                          "What can I help with?",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ibmPlexMono(
                            fontWeight: FontWeight.bold,
                            fontSize: 48,
                          ),
                        ),
                        UIHelpers.verticalSpace(24),
                      },
                      SizedBox(
                        height: 82,
                        child: TextFormField(
                          autofocus: true,
                          enabled: state is! GetResponseForQueryLoadingState,
                          controller: BlocProvider.of<ChatBloc>(context)
                              .queryController,
                          onFieldSubmitted: state
                                  is GetResponseForQueryLoadingState
                              ? null
                              : (value) => BlocProvider.of<ChatBloc>(context)
                                  .add(GetResponseForQueryEvent()),
                          validator: (value) {
                            if (value == null || value == "") {
                              return "";
                            }

                            return null;
                          },
                          focusNode: queryFieldFocusNode,
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: Color(0xFF3D2D4C),
                          ),
                          decoration: InputDecoration(
                            hintText: "Enter your query here!",
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xFF3D2D4C),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xFF3D2D4C),
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xFF3D2D4C),
                              ),
                            ),
                            contentPadding: EdgeInsets.all(27),
                            suffix: InkWell(
                                onTap: state is GetResponseForQueryLoadingState
                                    ? null
                                    : () => BlocProvider.of<ChatBloc>(context)
                                        .add(GetResponseForQueryEvent()),
                                child: Icon(
                                  Icons.send,
                                  color:
                                      state is GetResponseForQueryLoadingState
                                          ? Colors.grey
                                          : Color(0xFF8E12D5),
                                )),
                          ),
                        ),
                      ),
                      UIHelpers.verticalSpace(31),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
