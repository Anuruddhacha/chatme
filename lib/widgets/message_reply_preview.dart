

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/providers/message_reply_provider.dart';

class MessageReplyPreview extends ConsumerWidget{

MessageReplyPreview();


void cancelReply(WidgetRef ref){
  ref.read(messageReplyProvider.state).update((state) => null);
}

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final messageReply = ref.watch(messageReplyProvider);

    return Container(
      width: 350,
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [


          Row(
            children: [

             Expanded(child: Text(
            messageReply!.isMe ? 'Me' : 'Opposite',
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
            )),

            GestureDetector(
              child: const Icon(Icons.close,size: 16,),
              onTap: (){

              },
            )

            ],
          )



        ],
      ),
    );
  }





}