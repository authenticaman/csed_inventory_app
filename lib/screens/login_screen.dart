import 'package:csed_inventory/screens/admin_dashboard_screen.dart';
import 'package:csed_inventory/screens/forgot_password_screen.dart';
import 'package:csed_inventory/screens/registration_screen.dart';
import 'package:csed_inventory/screens/user_dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../helper/helper_function.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //form key
  final _formKey = GlobalKey<FormState>();

  //editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  String _adminLogin = '';

  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your email");
          }
          if (!RegExp("^[a-z0-9+_.-]+@[nitc]+.[ac]+.[in]").hasMatch(value)) {
            return ("Please enter a valid email");
          }
          if (RegExp("^[csedpurchase]+@[nitc]+.[ac]+.[in]").hasMatch(value)) {
            _adminLogin = emailController.text;
          }
          if (RegExp("^[hodsced]+@[nitc]+.[ac]+.[in]").hasMatch(value)) {
            _adminLogin = emailController.text;
          }
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ));
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regExp = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required");
          }
          if (!regExp.hasMatch(value)) {
            return ("Please enter 6 digit password");
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ));

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Colors.deepPurple,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          //minWidth: MediaQuery.of(context).size.width,
          minWidth: 60,
          onPressed: () {
            signIn(emailController.text, passwordController.text);
          },
          child: const Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          height: 200,
                          child: Image.asset(
                            "assets/welcome.png",
                            fit: BoxFit.contain,
                          )),
                      SizedBox(height: 45),
                      emailField,
                      SizedBox(height: 25),
                      passwordField,
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Text("Don't have an account ?"),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPassword()));
                              },
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      loginButton,
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account ?"),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegistrationScreen()));
                              },
                              child: const Text(
                                "SignUp",
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        if (_adminLogin == '') {
          await _auth
              .signInWithEmailAndPassword(email: email, password: password)
              .then((uid) async {
            if (uid != null) {
              Fluttertoast.showToast(msg: "Login Successful");
              await HelperFunctions.saveUserLoggedInStatus(true);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const UserDashboardScreen()));
            } else {
              setState(() {
                _isLoading = false;
              });
            }
          });
        } else {
          await _auth
              .signInWithEmailAndPassword(email: email, password: password)
              .then((uid) async {
            if (uid != null) {
              Fluttertoast.showToast(msg: "Admin Login Successful");
              await HelperFunctions.saveUserLoggedInStatus(true);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const AdminDashboardScreen()));
            } else {
              setState(() {
                _isLoading = false;
              });
            }
          });
        }
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(msg: e.code);
      }
    }
  }
}
