import 'package:flutter/material.dart';
import 'package:public_chat_app_flutter/models/message_model.dart';

class MessageItem extends StatelessWidget {
  final MessageModel messageModel;
  const MessageItem({Key? key, required this.messageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text(messageModel.userName ?? messageModel.email),
              subtitle: Text(messageModel.timestamp.toString()),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(messageModel.msg),
            ),
          ],
        ),
      ),
    );
  }
}
