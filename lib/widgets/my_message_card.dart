import 'package:flutter/material.dart';
import 'package:whatsapp/common/enums/message_enum.dart';

import '../colors.dart';
import 'display_text_image_gif.dart';
class MyMessageCard extends StatelessWidget {
  final String message;
  final String date;
  final MessageEnum type;
  final VoidCallback swifeLeft;
  final String replyText;
  final String username;
  final MessageEnum repliedMessageType;

  const MyMessageCard({Key? key,
   required this.message,
    required this.date,
     required this.type,
      required this.swifeLeft,
       required this.replyText,
        required this.username,
         required this.repliedMessageType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: messageColor,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: type == MessageEnum.text ? const EdgeInsets.only(
                  left: 10,
                  right: 30,
                  top: 5,
                  bottom: 20,
                ): EdgeInsets.only(
                  left: 10,
                  top: 10,
                  right: 10,
                  bottom: 25
                ),
                child: DisplayTextImageGif(message: message, type: type),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      date,
                      style:const TextStyle(
                        fontSize: 13,
                        color: Colors.white60,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.done_all,
                      size: 20,
                      color: Colors.white60,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
