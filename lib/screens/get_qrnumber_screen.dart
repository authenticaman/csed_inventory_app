import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rich_clipboard/rich_clipboard.dart';

class GetQrNumberScreen extends StatefulWidget {
  const GetQrNumberScreen({Key? key, required this.documentId})
      : super(key: key);
  final String documentId;

  @override
  State<GetQrNumberScreen> createState() => _GetQrNumberScreenState();
}

class _GetQrNumberScreenState extends State<GetQrNumberScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Container(
              color: Colors.lightBlue.shade50,
                height: 400,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Copy QR Generator Key Here!!",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    SelectableText(
                      widget.documentId,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ))),
      ),
    );
  }
}
