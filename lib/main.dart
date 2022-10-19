import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/colors.dart';
import 'package:whatsapp/common/widgets/error.dart';
import 'package:whatsapp/features/auth/controller/auth_controller.dart';
import 'package:whatsapp/features/landing/screens/landing_screen.dart';
import 'package:whatsapp/features/select_contacts/screen/select_contacts_screen.dart';
import 'package:whatsapp/firebase_options.dart';
import 'package:whatsapp/models/user_model.dart';
import 'package:whatsapp/router.dart';
import 'package:whatsapp/screens/mobile_layout_screen.dart';
import 'common/widgets/loader.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    name: 'my-do-chatapp'
  );
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'WhatsChat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
        color: appBarColor
        )
      ),
      home:ref.watch(userdataAuthProider).when(

        data: (user){
        if(user == null){
          return const LandingScreen();
        }
        return const MobileLayoutScreen();
      },
      error: (error,trace){
      return ErrorScreen(error: error.toString());
      },
      loading: (){
          return const Loader();
      }) ,
      onGenerateRoute: (settings)=> generateRoute(settings),
    );
  }
}
