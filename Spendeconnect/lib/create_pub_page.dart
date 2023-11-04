import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'image_picker_controller.dart';


class CreatePub extends StatefulWidget {
  const CreatePub({super.key});

  @override
  State<CreatePub> createState() => _CreatePubState();
}

class _CreatePubState extends State<CreatePub> {
  final _formKey = GlobalKey<FormState>();
  final titlePub = TextEditingController();
  final pubDescription = TextEditingController();
  final amountNeeded = TextEditingController();

  final controller = Get.put(ImagePickerController());

  @override
  void dispose() {
    super.dispose();

    titlePub.dispose();
    pubDescription.dispose();
    amountNeeded.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      hintText: 'worum geht es',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "you must feel this feld";
                      }
                      return null;
                    },
                    controller: titlePub,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    minLines: 5,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText: 'Give a description',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "you must feel this feld";
                      }
                      return null;
                    },
                    controller: pubDescription,
                  ),
                ),
                Obx(() {
                  return Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 20),
                    child: controller.image.value.path == ''
                        ? const Icon(
                      Icons.file_download,
                      size: 60,
                    )
                        : Image.file(File(controller.image.value.path),
                      height: 150,
                      width: 300,
                      fit: BoxFit.contain, ),
                  );
                }),
                ElevatedButton(
                    onPressed: () {
                      controller.pickImage();

                      },
                    child: const Text(
                      "choose a image",
                      style: TextStyle(color: Colors.black),
                    )),
                Container(
                    margin: const EdgeInsets.only(bottom: 10,top: 10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Amount needed',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "you must feel this feld";
                        }
                        return null;
                      },
                      controller: amountNeeded,
                    )),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green)
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String imageUrl = await ImagePickerController.uploadImageToFirebase(File(controller.image.value.path));
                      print('Image uploaded. Download URL: $imageUrl');

                      final titlePubRe = titlePub.text;
                      final pudDescriptionRe = pubDescription.text;
                      final amountRe = amountNeeded.text;
                      final imageDownloadUrl = imageUrl; // Utilisez l'URL de l'image téléchargée depuis Firebase

                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Envoi en cours ...")));
                      FocusScope.of(context).requestFocus(FocusNode());

                      CollectionReference postRef = FirebaseFirestore.instance.collection("Post");
                      postRef.add({
                        "title": titlePubRe,
                        "text": pudDescriptionRe,
                        "amount" : amountRe,
                        "image_url": imageDownloadUrl, // Ajoutez l'URL de l'image à Firebase

                      });
                    }
                  },
                  child: Text("create",),
                ),
              ],
            )),
      ),
    );
  }
}
