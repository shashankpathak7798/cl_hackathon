import 'package:cl_hackathon/ui_helpers.dart';
import 'package:flutter/material.dart';

class ChatDesktopView extends StatelessWidget {
  ChatDesktopView({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UIHelpers.verticalSpaceRegular,
        Icon(
          Icons.smart_toy,
          size: 40,
        ),
        UIHelpers.verticalSpaceSmall,
        Text("CL HACKATHON"),
        UIHelpers.listDivider,
        Expanded(
          child: Column(
            children: [],
          ),
        ),
        UIHelpers.listDivider,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Enter your query here!",
              hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
                borderSide: BorderSide(
                  width: 0.3,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
        UIHelpers.verticalSpaceTiny,
      ],
    );
  }
}
