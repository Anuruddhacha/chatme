


import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerItem({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late CachedVideoPlayerController _videoPlayerController;
  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = CachedVideoPlayerController.network(widget.videoUrl)..initialize()
    .then((value){
      _videoPlayerController.setVolume(1);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: 16 / 9,
    child: Stack(
      children: [
          CachedVideoPlayer(_videoPlayerController),
          Align(
            alignment: Alignment.center,
            child: IconButton(onPressed: (){
                if(isPlay){
                  _videoPlayerController.pause();
                } 
                else{
                  _videoPlayerController.play();
                }

                setState(() {
                  isPlay = !isPlay;
                });
            },
             icon: Icon(
               isPlay ? Icons.pause_circle: Icons.play_circle )),
          )
      ],
    ),);
  }
}