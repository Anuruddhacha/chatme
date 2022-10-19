

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../colors.dart';
import '../../../common/widgets/custom_button.dart';
import '../../auth/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

   final size = MediaQuery.of(context).size;


    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

         Column(
          children: [
            const SizedBox(height: 50,),
         const Text("Welcome to whatsapp",
         style: TextStyle(fontSize: 33,fontWeight: FontWeight.w600,color: textColor),),
         SizedBox(height:size.height / 9),
          ],
         ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 40),
            child: CustomButton(text: "AGREE AND CONTINUE", onPressed: (){
                 Navigator.pushNamed(context, LoginScreen.routeName);
            }),
          )

        ],
      )),
    );
  }
}