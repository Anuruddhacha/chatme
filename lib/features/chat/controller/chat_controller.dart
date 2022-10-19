import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/enums/message_enum.dart';
import 'package:whatsapp/features/auth/controller/auth_controller.dart';
import 'package:whatsapp/features/chat/repository/chat_repository.dart';
import 'package:whatsapp/models/chat_contact.dart';
import 'package:whatsapp/models/message.dart';
import '../../../models/user_model.dart';

final chatControllerProvider = Provider((ref){
final chatRepository = ref.watch(chatRepoProvider);


return ChatController(
  chatRepository: chatRepository,
   ref: ref);

});

class ChatController{

  final ChatRepository chatRepository;
  final ProviderRef ref;

  ChatController({required this.chatRepository, required this.ref});


  void sendTextMessage(
    {
required BuildContext context,
required String text,
required String receiverUserID,
}
  ){
ref.watch(userdataAuthProider).whenData((value){

  chatRepository.sendTextMessage(context: context,
 text: text,
  receiverUserID: receiverUserID,
   senderUSer: value!);
}
 );
    
  }


  Stream<List<ChatContact>> getChatContacts(){
    return chatRepository.getChatContacts();
  }

  Stream<List<Message>> chatStream(String receiverUserId){
    return chatRepository.getChatStream(receiverUserId);
  }


   void sendFileMessage(
    {
required BuildContext context,
required File file,
required String receiverUserID,
required MessageEnum messageEnum,
}
  ){
ref.watch(userdataAuthProider).whenData((value){

  chatRepository.sendFileMessage(context: context,
   file: file,
   receiverUserID: receiverUserID,
   senderUserData: value!,
   ref: ref,
   messageEnum: messageEnum);


}
 );
    
  }


  void sendGIFMessage(
  BuildContext context,
  String gifUrl,
  String receiverUserID,){
   
   int gifUrlPartIndex = gifUrl.lastIndexOf('-')+ 1;
    
  String gifUrlPart = gifUrl.substring(gifUrlPartIndex);

  String newgifUrl =  'https://i.giphy.com/media/$gifUrlPart/200.gif';


  ref.read(userdataAuthProider).whenData((value) => 
  chatRepository.sendGIFMessage(context: context,
   gifUrl: newgifUrl,
    receiverUserID: receiverUserID,
     senderUSer: value!)
     );
  }


  
}