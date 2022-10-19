

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../colors.dart';
import '../../../common/widgets/custom_button.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {

  static const routeName = "/login-screen";


  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {


final phoneController = TextEditingController();
Country? country;


  @override
  Widget build(BuildContext context) {
    final size   = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(title: const Text("Enter your phone number"),
      elevation: 0,
      backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
      
              Column(
                children: [  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: const Text("WhatsApp will need to verify your phone number",
                  style: TextStyle(
                    color: Colors.white
                  ),),
                ),
      
                SizedBox(height: 10,),
      
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: GestureDetector(
                    onTap: (){
                  pickCountry(context);
                    },
                    child: const Text("Pick country",
                    style: TextStyle(
                      color: Colors.blue
                    ),),
                  ),
                ),
      
                Row(
                  children: [
      
          (country != null) ?  Text('+${country!.phoneCode}',style: TextStyle(color: Colors.white),):
          Text(""),
      
           SizedBox(width: 4,),
           SizedBox(width: size.width * 0.7,
           child: TextField(
            controller: phoneController,
            style: TextStyle(color: Colors.white,),
            
            decoration: InputDecoration(
              hintText: 'phone number',
              hintStyle: TextStyle(color: Colors.white)
            ),
           ),
           ),
          
           
           ])],
              ),
      
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: CustomButton(text: "NEXT",
                onPressed: (){
              
                  sendPhoneNumber();
      
                }),
              )
      
      
      
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry(BuildContext context){
    
showCountryPicker(
  context: context,
  showPhoneCode: true,
   onSelect: (Country _country){
  setState(() {
    country = _country;
  });
  print(country);
   },
   countryListTheme: CountryListThemeData(
    backgroundColor: backgroundColor,
    textStyle: TextStyle(
      color: Colors.white,
    ),
    
   )
   );




  }

  void sendPhoneNumber(){
    String phoneNumber = phoneController.text.trim();

    if(country != null && phoneNumber.isNotEmpty){
      print("verfying----");
      ref.read(authControlerProvider).signInWithPhone('+${country!.phoneCode}${phoneNumber}', context);
    }

  }
}