//import 'dart:html';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    // Reference ref = _storage.ref().child(childName).child('id');
    Reference ref  = _storage.ref('/image'+DateTime.now().microsecondsSinceEpoch.toString());
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
  Future<String> saveData({
    required String ItemCode,
    required String ItemDesc,
    required Uint8List file,
    required timestamp,
  }) async {
    String resp = " Some Error Occurred";
    try{
      if(ItemCode.isNotEmpty || ItemDesc.isNotEmpty) {
        String imageUrl = await uploadImageToStorage('Image', file);
        await _firestore.collection('QRImages').add({
          'ItemCode': ItemCode,
          'ItemDesc': ItemDesc,
          'imageLink': imageUrl,
          'timestamp': timestamp,
        });
        Fluttertoast.showToast(msg: "Uploaded successfully");
        resp = 'success';
      }
    }
    catch(err){
      resp =err.toString();
    }
    return resp;
  }

}