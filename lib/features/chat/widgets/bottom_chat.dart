import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp/common/enums/message_enum.dart';
import 'package:whatsapp/features/chat/controller/chat_controller.dart';
import 'package:whatsapp/utils/utility.dart';
import 'package:whatsapp/widgets/message_reply_preview.dart';
import '../../../colors.dart';
import '../../../common/providers/message_reply_provider.dart';

class BottomChatField extends ConsumerStatefulWidget {

  final String receiverUserID;


  const BottomChatField({required this.receiverUserID});

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  bool isShowSendButton = false;
  final TextEditingController _messageController = TextEditingController();
  bool isShowEmoji = false;
  FocusNode focusNode = FocusNode();
  FlutterSoundRecorder? _soundRecorder;
  bool isRecorerInit = false;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    _soundRecorder = FlutterSoundRecorder();
    openAudio();
  }

  void openAudio() async{

final status  =await Permission.microphone.request();
if(status != PermissionStatus.granted){
  throw RecordingPermissionException('Mic Error');
}
  await _soundRecorder!.openRecorder();
  isRecorerInit = true;
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
    _soundRecorder!.closeRecorder();
    isRecorerInit = false;
  }


  void hideEmojiContainer(){
  setState(() {
    isShowEmoji = false;
  });

  }

   void showEmojiContainer(){
  setState(() {
    isShowEmoji = true;
  });

  }

  void toggleEmojiKeyboard(){
  if(isShowEmoji){
     showKeyboard();
     hideEmojiContainer();
  }else{
   hideKeyBoard();
   showEmojiContainer();
  }

  }

  void showKeyboard(){
    return focusNode.requestFocus();
  }

void hideKeyBoard(){
return focusNode.unfocus();
}

void sendTextMEssage() async{
if(isShowSendButton){

ref.read(chatControllerProvider).sendTextMessage(
  context: context,
  text: _messageController.text.trim(),
  receiverUserID: widget.receiverUserID);

_messageController.clear();
}else{
print("audioooooooooooooooooo");
var tempDir = await getTemporaryDirectory();
var path = '${tempDir.path}/flutter_sound.aac';

 if(!isRecorerInit){
  print("audioooooooooooooooooo stoppppppp");
  return; //return from method
 }

 if(isRecording){
  print("audioooooooooooooooooo stoping");
  await _soundRecorder!.stopRecorder();

  sendFileMessage(File(path), MessageEnum.audio);

 }else{
  print("audioooooooooooooooooo starting");
  await _soundRecorder!.startRecorder(
    toFile: path
  );
 }

setState(() {
    isRecording = !isRecording;
  });


}





}

void sendFileMessage(File file,
MessageEnum messageEnum){
  ref.read(chatControllerProvider).sendFileMessage(
    context: context,
     file: file,
      receiverUserID: widget.receiverUserID,
       messageEnum: messageEnum);
}

void selectImage() async{
File? image = await pickImageFromGallery(context);
if(image!=null){
 sendFileMessage(image, MessageEnum.image);
}

}

void selectVideo() async{
File? video = await pickVideoFromGallery(context);
if(video!=null){
 sendFileMessage(video, MessageEnum.video);
}

}

void selectGIF() async{
final gif = await pickGif(context);
if(gif!=null){
  ref.read(chatControllerProvider).sendGIFMessage(context,
   gif.url,
    widget.receiverUserID);

}

}





  @override
  Widget build(BuildContext context) {

 final messageReply = ref.watch(messageReplyProvider);
 final isShowMessageReply = messageReply != null;

    return Column(

       

      children: [
                isShowMessageReply ?  MessageReplyPreview() :  SizedBox(),

            Row(
      children: [
        Expanded(
          child: TextField(
            focusNode: focusNode,
            controller: _messageController,
            onChanged: (val){
              if(val.isNotEmpty){
                setState(() {
                  isShowSendButton = true;
                });
              }
              else{
                setState(() {
                  isShowSendButton = false;
                });
              }
            },
            style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
          filled: true,
          fillColor: mobileChatBoxColor,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(onPressed: (){
                  toggleEmojiKeyboard();
                  },
                   icon: Icon(Icons.emoji_emotions, color: Colors.grey,)),
                  
                  IconButton(onPressed: (){
                   selectGIF();
                  },
                   icon: Icon(Icons.gif, color: Colors.grey,))
                ],
              ),
            ),
          ),
          suffixIcon: SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:  [
                IconButton(onPressed: (){
                  selectImage();
                },
                 icon: Icon(Icons.camera_alt, color: Colors.grey,),),

                 IconButton(onPressed: (){
                  selectVideo();
                 },
                 icon: Icon(Icons.attach_file, color: Colors.grey,),),
              ],
            ),
          ),
          hintText: 'Type a message!',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          contentPadding: const EdgeInsets.all(10),
              ),
            ),
        ),

    Padding(
      padding: EdgeInsets.only(
        bottom: 8,
        right: 2,
        left: 2
      ),
      child: CircleAvatar(
        backgroundColor: Colors.blue,
        child: GestureDetector(
          onTap: (){
             sendTextMEssage();
          },
          child: Icon(isShowSendButton ? Icons.send : isRecording ? Icons.close:  Icons.mic,
          
          color: Colors.white,),
        ),
      ),
    )


      ],
    ),
  isShowEmoji ?  SizedBox(height: 310,
    child: EmojiPicker(
      onEmojiSelected: (category, emoji) {
        setState(() {
          _messageController.text = _messageController.text + emoji.emoji;
        });

        if(!isShowSendButton){
          setState(() {
            isShowSendButton = true;
          });
        }
      },
      
    ),) : SizedBox()


      ],
    );
  }
}