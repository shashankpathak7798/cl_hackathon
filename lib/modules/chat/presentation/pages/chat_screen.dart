import 'package:cl_hackathon/modules/chat/presentation/views/chat_desktop_view.dart';
import 'package:cl_hackathon/responsive.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        key: UniqueKey(),
        mobile: Placeholder(),
        tablet: ChatDesktopView(),
        desktop: ChatDesktopView(),
      ),
    );
  }
}
