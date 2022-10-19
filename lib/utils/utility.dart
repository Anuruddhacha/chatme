

import 'dart:io';

import 'package:enough_giphy_flutter/enough_giphy_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar({required BuildContext context, required String content}){

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(content)),
  );

}


Future<File?> pickImageFromGallery(BuildContext context) async{
File? image;

try{
final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

if(pickedImage != null){
  image = File(pickedImage.path);//type XFile to a File

}
} catch(e){
showSnackBar(context: context, content: e.toString());

}
return image;

}


Future<File?> pickVideoFromGallery(BuildContext context) async{
File? video;

try{
final pickedVideo = await ImagePicker().pickVideo(source: ImageSource.gallery);

if(pickedVideo != null){
  video = File(pickedVideo.path);//type XFile to a File

}
} catch(e){
showSnackBar(context: context, content: e.toString());

}
return video;

}

pickGif(BuildContext context) async{
//dKQ9GebWRiMAC2NPl5cI5jLghDu8YnJj
GiphyGif? gif;

try{
gif = await Giphy.getGif(context: context, apiKey: "dKQ9GebWRiMAC2NPl5cI5jLghDu8YnJj");


}catch(e){
 showSnackBar(context: context, content: e.toString());

}
return gif;

}
