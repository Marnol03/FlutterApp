import 'dart:io';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController{

  Rx<File> image = File('').obs;

  Future pickImage()async {
  try{

    final imagePick = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(imagePick == null){
      print("no image");
      return;
    }
    final imageTemp = File(imagePick.path);
    image.value = imageTemp;
  }on PlatformException catch (e){
    return e;
  }
  }

  static Future<String> uploadImageToFirebase(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e.toString());
      return '';
    }
  }
}