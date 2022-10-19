import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp/common/widgets/loader.dart';
import 'package:whatsapp/features/chat/controller/chat_controller.dart';
import 'package:whatsapp/models/chat_contact.dart';
import '../colors.dart';
import '../info.dart';
import '../screens/mobile_chat_screen.dart';


class ContactsList extends ConsumerWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: StreamBuilder<List<ChatContact>>(

        stream: ref.watch(chatControllerProvider).getChatContacts(),
        builder: (context, snapshot) {
     
        if(snapshot.connectionState == ConnectionState.waiting){
          return Loader();
        }
            
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: ((context, index) {

            var chatContact = snapshot.data![index];

            return Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>  MobileChatScreen(
                        name: chatContact.name,
                        uid: chatContact.contactID,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    title: Text(
                      chatContact.name,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        chatContact.lastMessage,
                        style: const TextStyle(fontSize: 15, color: Colors.grey),
                        
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        chatContact.profilePic.length < 10 ? 
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTY0VhU4LoEJsnBFw9EXvncf_9TmKeDYu_BHxBMnlXvXxJQCkCeyN5wncFTHgU1V4RoeWE&usqp=CAU'
                        : chatContact.profilePic
                      ),
                      radius: 30,
                    ),
                    trailing: Text(
                      DateFormat.Hm().format(chatContact.timeSent),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(color: dividerColor, indent: 85),
            ],
          );
          }));
        },
      ),
    );
  }
}
