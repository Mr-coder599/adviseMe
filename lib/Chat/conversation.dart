import 'package:flutter/material.dart';

class ConversationChat extends StatefulWidget {
  const ConversationChat({Key? key}) : super(key: key);

  @override
  State<ConversationChat> createState() => _ConversationChatState();
}

class _ConversationChatState extends State<ConversationChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload with Data'),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(),
    );
  }
}
