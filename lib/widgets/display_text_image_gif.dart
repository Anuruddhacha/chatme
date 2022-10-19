


import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whatsapp/common/enums/message_enum.dart';
import 'package:whatsapp/widgets/video_player_item.dart';

import '../colors.dart';

class DisplayTextImageGif extends StatelessWidget {

  final String message;
  final MessageEnum type;

  const DisplayTextImageGif({Key? key,
   required this.message,
    required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool isPlaying = false;
    final AudioPlayer audioPlayer = AudioPlayer();

    return type == MessageEnum.text ? Text(
                  message,
                  style: const TextStyle(
                    fontSize: 16,
                    color: textColor
                  ),
                ) : type == MessageEnum.audio ? 
                StatefulBuilder(
                  builder:(context, setState){
                     return  IconButton(
                  constraints: const BoxConstraints(
                    maxWidth: 100
                  ),
                  onPressed: () async{
                      
                       if(isPlaying){
                        await audioPlayer.pause();
                        setState((){
                          isPlaying = false;
                        });
                       }else{
                        audioPlayer.play(UrlSource(message));
                        setState((){
                          isPlaying = true;
                        });
                       }
                   
                 },
                  icon: Icon( isPlaying ? Icons.pause_circle : Icons.play_circle,color: Colors.white,));
                })
                  
                 : type == MessageEnum.video ?
                 VideoPlayerItem(videoUrl: message,)
                 : type == MessageEnum.gif ?
                  CachedNetworkImage(imageUrl: message)
                     : CachedNetworkImage(
                     imageUrl: message,
                );
  }
}