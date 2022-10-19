
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/common/widgets/error.dart';
import 'package:whatsapp/features/auth/screens/OTP_screen.dart';
import 'package:whatsapp/features/auth/screens/login_screen.dart';
import 'package:whatsapp/features/auth/screens/user_info.dart';
import 'package:whatsapp/features/select_contacts/screen/select_contacts_screen.dart';
import 'package:whatsapp/screens/mobile_chat_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings){

  switch(settings.name){
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case SelectContactScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SelectContactScreen());
    case MobileChatScreen.routeName:
    final args = settings.arguments as Map<String,dynamic>;
    final name = args['name'];
    final uid =  args['uid'];
      return MaterialPageRoute(builder: (context) =>  MobileChatScreen(
        name:name,
        uid: uid,
      ));
    case OTPScreen.routeName:
      final verificationID = settings.arguments as String;
      return MaterialPageRoute(builder: (context) =>  OTPScreen(verificationID: verificationID,));
    case UserInfoScreen.routeName:
      return MaterialPageRoute(builder: (context) => const UserInfoScreen());
    default: 
      return MaterialPageRoute(builder: (context)=>const Scaffold(
     body: ErrorScreen(error: "Not found"),
      ));
  }

}