import 'package:cl_hackathon/modules/chat/presentation/bloc/chat_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBotMobileView extends StatelessWidget {
  const ChatBotMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Center(
              child: Column(
                children: [
                  Icon(Icons.smart_toy, size: 40, color: Colors.teal),
                  Text(
                    "Hello, there",
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<ChatBlocBloc, ChatBlocState>(
                builder: (context, state) {
                  if (state is ChatBotLoaded && state.messages!.isNotEmpty) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: state.messages?.length ?? 0,
                      itemBuilder: (context, index) {
                        final message = state.messages?[index];
                        final isUserMessage = message?.isUser;
                        return Align(
                          alignment: isUserMessage ?? false
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              color: isUserMessage ?? false
                                  ? Colors.teal.shade200
                                  : Colors.teal.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              message!.text,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  if (state is GetResponseForQueryLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.teal),
                    );
                  }
                  if (state is GetResponseForQueryFailureState) {
                    return const Center(
                      child: Text(
                        "Something went wrong...",
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const Center(child: Text("Start chatting..."));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Ask me anything...",
                        hintStyle: const TextStyle(color: Colors.teal),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(context, _controller),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.teal),
                    onPressed: () => _sendMessage(context, _controller),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage(BuildContext context, TextEditingController controller) {
    if (controller.text.trim().isNotEmpty) {
      final userMessage = controller.text.trim();
      context.read<ChatBlocBloc>().add(SendMessageEvent(message: userMessage));
      controller.clear();
    }
  }
}
