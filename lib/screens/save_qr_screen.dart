import 'dart:developer';
import 'dart:typed_data';
//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csed_inventory/screens/admin_dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../helper/utils.dart';
import '../resource/add_data.dart';

class SaveQrImageScreen extends StatefulWidget {
  const SaveQrImageScreen({Key? key}) : super(key: key);

  @override
  State<SaveQrImageScreen> createState() => _SaveQrImageScreenState();
}

class _SaveQrImageScreenState extends State<SaveQrImageScreen> {

  final TextEditingController itemCodeController = TextEditingController();
  final TextEditingController itemDescController = TextEditingController();

  Uint8List? _image;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }
  void saveDetails() async{
    String ItemCode = itemCodeController.text;
    String ItemDesc = itemDescController.text;
    String resp = await StoreData().saveData(ItemCode:ItemCode,ItemDesc:ItemDesc,file:_image!,timestamp: DateTime.timestamp());
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AdminDashboardScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Save QR"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 32
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24,
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                    radius: 64,
                    backgroundImage: MemoryImage(_image!),
                  )
                      : const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        'https://png.pngitem.com/pimgs/s/421-4212266_transparent-default-avatar-png-default-avatar-images-png.png'),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: itemCodeController,
                decoration: const InputDecoration(
                  hintText: 'Item Code',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ) ,
              SizedBox(height: 24,),
              TextField(
                controller: itemDescController,
                decoration: const InputDecoration(
                  hintText: 'Item Description',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ) ,
              SizedBox(height: 24,),
              ElevatedButton(
                onPressed: saveDetails,
                child: const Text('Save QR'),
              )
            ],
          ),
        ),
      ),
    );


  }
}