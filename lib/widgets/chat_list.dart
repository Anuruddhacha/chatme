import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp/common/widgets/loader.dart';
import 'package:whatsapp/features/chat/controller/chat_controller.dart';
import 'package:whatsapp/models/message.dart';
import 'package:whatsapp/widgets/my_message_card.dart';
import 'package:whatsapp/widgets/sender_message_card.dart';

class ChatList extends ConsumerStatefulWidget {
  final String receiverUserID;
  const ChatList({required this.receiverUserID});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {

  final ScrollController _messageController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<List<Message>>(
      stream: ref.read(chatControllerProvider).chatStream(widget.receiverUserID),
      builder: (context,snapshot){

        if(snapshot.connectionState == ConnectionState.waiting){
          return Loader();
        }

      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        _messageController.jumpTo(_messageController.position.maxScrollExtent);
      });

       return ListView.builder(
        controller: _messageController,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        final messageData = snapshot.data![index];
        var timeSent = DateFormat.Hm().format(messageData.timeSent);

        if (messageData.senderId.replaceAll(' ', '') == FirebaseAuth.instance.currentUser!.uid) {
          return MyMessageCard(
            message: messageData.text.toString(),
            date: timeSent,
            type: messageData.type,
          );
        }
        return SenderMessageCard(
          message: messageData.text.toString(),
          date: timeSent,
          type: messageData.type,
        );
      },
    );



    });
  }

  }



