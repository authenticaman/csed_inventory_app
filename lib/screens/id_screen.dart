import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IdScreeen extends StatelessWidget {
  const IdScreeen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(40),
        color: Colors.white70,
        child: Column(
          children: [
            Text(
          //DocumentReference doc =  ${doc.id};
              "",
            )
          ],
        ),
      ),
    );
  }
}
