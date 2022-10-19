import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/widgets/loader.dart';
import 'package:whatsapp/features/auth/controller/auth_controller.dart';
import 'package:whatsapp/features/select_contacts/screen/select_contacts_screen.dart';

import '../colors.dart';
import '../features/chat/widgets/bottom_chat.dart';
import '../info.dart';
import '../models/user_model.dart';
import '../widgets/chat_list.dart';

class MobileChatScreen extends ConsumerWidget {
  final String name;
  final String uid;
  static const String routeName = '/mobile-chat-screen'; 

   MobileChatScreen({required this.name,required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: StreamBuilder<User_Model>(
          stream: ref.read(authControlerProvider).getUserDataByID_2(uid),
          builder: (context, snapshot) {
            
            if(snapshot.connectionState == ConnectionState.waiting){
            return Loader();
            }
            

           return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,style: TextStyle(fontSize: 16),),
                Text(snapshot.data!.isOnline ? 'online' : 'offline',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: Colors.white
                ),),
              ],
            );
          

        },),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
     
      body: Column(
        children: [
           Expanded(
            child: ChatList(
              receiverUserID: uid,
            ),
          ),
          BottomChatField(receiverUserID: uid.replaceAll(' ', ''),),
        ],
      ),
      
    );
  }
}

