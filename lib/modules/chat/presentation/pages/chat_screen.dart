import 'package:cl_hackathon/modules/chat/presentation/bloc/chat_bloc_bloc.dart';

import 'package:cl_hackathon/modules/chat/presentation/views/chat_desktop_view.dart';
import 'package:cl_hackathon/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBlocBloc(),
      child: Scaffold(
        backgroundColor: Color(0xFFF0F7FB),
        body: Responsive(
          key: UniqueKey(),
          mobile: ChatView(),
          tablet: ChatView(),
          desktop: ChatView(),
        ),
      ),
    );
  }
}
