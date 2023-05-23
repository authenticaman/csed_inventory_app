import 'package:csed_inventory/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Forgot Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.mail),
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),),
            SizedBox(height: 40,),
            TextButton(onPressed:() {
              auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value){
                Fluttertoast.showToast(msg: "Email to reset password has been sent");
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              }).onError((error, stackTrace) {
                Fluttertoast.showToast(msg: "Error");

              });
            },
                child: Text('Reset Password'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.deepPurple,
              ),
            )

          ],
        ),
      ),
    );
  }
}
