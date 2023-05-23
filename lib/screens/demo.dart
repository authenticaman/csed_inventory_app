// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_database/firebase_database.dart';
//
//
//
// class loginDatabase {
//   final databaseReference = FirebaseDatabase.instance.reference();
//   final CollectionReference std =
//   FirebaseFirestore.instance.collection('STUDENTS');
//
//   Future<bool> serachEmailInStudents(String?Email)
//   async {
//     final QuerySnapshot querySnapshot = await  std.where('email', isEqualTo: Email)
//         .get();
//     if (querySnapshot.docs.length > 0) {
//       print('Email found in students');
//       return true;
//     }
//     else {
//       print('No Email is present in students table');
//       return false;
//     }
//   }
//
//   Future<bool> serachEmailPassInStudents(String?Email,String?pass)
//   async {
//     final QuerySnapshot querySnapshot = await std.where('email', isEqualTo: Email)
//         .where('password',isEqualTo: pass)
//         .get();
//     if (querySnapshot.docs.length > 0) {
//       print('email and rn is correct in students table');
//       return true;
//     }
//     else {
//       print('password is miss matching');
//       return false;
//     }
//   }
// }
//
//
// import 'dart:io';
// import 'package:flutter/material.dart';
// //import 'package:project/loginDatabase.dart';
// import 'loginDatabase.dart';
// //import 'package:project/signup.dart';
// import 'signup.dart';
// import 'StudentsDashboard.dart';
// import 'VALIDATEResgister.dart';
// import 'Alter.dart';
// import 'package:path_provider/path_provider.dart';
// validateData obj = new validateData();
// loginDatabase loginObj = new loginDatabase();
//
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: studentsLogin(),
//       // home:FirestoreScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// /*callback()
//   {
//     print("You are registered\n");
//   }*/
// }

// class studentsLogin extends StatefulWidget {
//   @override
//   _studentsLoginState createState() => _studentsLoginState();
// }
//
// class _studentsLoginState extends State<studentsLogin> {
//   late String email;
//   late String password;
//   late String name, fname, mname;
//   late String number;
//   bool _obscureText = true;
//   late String user;
//
//   final _formkey=GlobalKey<FormState>();
//
//   get key => null;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text("Students Login")),
//         body: Stack(
//           children:<Widget>[
//
//             Form(
//               key: _formkey,
//               child: ListView(
//                 children: <Widget>[
//                   Padding(padding: const EdgeInsets.only(top: 10)),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextField(
//                       keyboardType: TextInputType.emailAddress,
//                       onChanged: (value) => email = value,
//                       decoration: InputDecoration(
//                         labelText:  "Enter Your Email...",labelStyle: TextStyle(fontWeight: FontWeight.bold),
//                         icon: Icon(Icons.email),
//                       ),
//                     ),
//                   ),
//                   //Padding(padding: const EdgeInsets.only(top: 10)),
//
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       autocorrect: false,
//                       obscureText: _obscureText,
//                       onChanged: (value) => password = value,
//                       decoration: InputDecoration(
//                         labelText:  "Enter Password...",labelStyle: TextStyle(fontWeight: FontWeight.bold),
//                         icon: Icon(Icons.lock),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             // Based on passwordVisible state choose the icon
//                             _obscureText ? Icons.visibility : Icons.visibility_off,
//                             color: Theme.of(context).primaryColorLight,
//                           ),
//                           onPressed: () {
//                             // Update the state i.e. toogle the state of passwordVisible variable
//                             setState(() {
//                               _obscureText = !_obscureText;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                   Button(
//                       text: 'Login',
//
//                       //  key:
//                       callback: () async {
//                         // print("You are logged in successfully\n");
//                         print("this is email");
//                         // fetching data from database
//
//                         // print("calling here");
//                         // DbConnection db=DbConnection();
//                         // await db.testing();
//                         // print("ending here");
//                         print(email+" "+password);
//                         if( password.length==0)
//                         {
//                           showDialog(context: context,
//                             builder: (BuildContext context) {
//                               return CustomAlertDialog(
//                                 title: '*Required!!',
//                                 message: 'Please Select All\n The Fields.',
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               );
//                             },
//                           );
//                         }
//                         if(email.length==0 )
//                         {
//                           showDialog(context: context,
//                             builder: (BuildContext context) {
//                               return CustomAlertDialog(
//                                 title: '*Required!!',
//                                 message: 'Please Select All\n The Fields.',
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               );
//                             },
//                           );
//                         }
//
//                         Future<bool> exists1 = loginObj.serachEmailInStudents(email) as Future<bool> ;
//                         bool temp1 = await exists1;
//                         Future<bool> exists2 = loginObj.serachEmailPassInStudents(email,password) as Future<bool> ;
//                         bool temp2 = await exists2;
//
//                         if(obj.checkEmail(email) == false)
//                         {
//                           showDialog(context: context,
//                             builder: (BuildContext context) {
//                               return CustomAlertDialog(
//                                 title: '*Wrong Format!!',
//                                 message: 'Please use NITC Email id.',
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               );
//                             },
//                           );
//                         }
//                         else if(temp1 == false)
//                         {
//                           print("FirstElseIf");
//                           showDialog(context: context,
//                             builder: (BuildContext context) {
//                               return CustomAlertDialog(
//                                 title: '*Use Valid Email!!',
//                                 message: 'Please use correct Email Id.',
//                                 onPressed: () {
//                                   //  Navigator.of(context).pop();
//
//                                   Navigator.of(context).pop();
//
//                                   Navigator.pushReplacement(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>  signup(),
//                                       ));
//                                 },
//
//                               );
//                             },
//                           );
//                         }
//                         else if(temp1 == true && temp2 == false)
//                         {
//                           print("secondElseif");
//                           showDialog(context: context,
//                             builder: (BuildContext context) {
//                               return CustomAlertDialog(
//                                 title: '*Incorrect Password!!',
//                                 message: 'Please type correct password\nAnd Retry again.',
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               );
//                             },
//                           );
//                         }
//                         else {
//                           print("Hii");
//                           Directory appDirectory = await getApplicationDocumentsDirectory();
//                           String filename = '${appDirectory.path}/file.txt';
//                           File file = File(filename);
//                           // for write data into file
//                           file.writeAsString(email)
//                               .then((_) => print('Data written to file successfully'))
//                               .catchError((error) => print('Error writing to file: $error'));
//
//                           // for reading data into file
//                           /* file.readAsString()
//                                .then((content) => print('File content:\n$content'))
//                                .catchError((error) => print('Error reading file: $error'));
//
//                           // for erasing data from file
//                            file.writeAsString('')
//                                .then((_) => print('File content erased successfully'))
//                                .catchError((error) => print('Error erasing file content: $error'));
// */
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => DashboardScreen(key: ValueKey('dashboard'))),
//                           );
//                         }
//
//                       }, key:Key("call"))
//                 ],
//               ),
//
//             ),
//           ],
//         ));
//   }
// }
//
// class Button extends StatelessWidget {
//   final VoidCallback callback;
//   final String text;
//
//   const Button({ required Key key, required this.callback, required this.text})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8.0),
//       child: Material(
//         color: Colors.blue,
//         elevation: 6.0,
//         borderRadius: BorderRadius.circular(30.0),
//         child: MaterialButton(
//           onPressed: callback,
//           // onPressed: (){
//           // Navigator.push(context, MaterialPageRoute(builder: (context)=> DashboardScreen(key:Key("call"))));
//           //},
//           minWidth: 200.0,
//           height: 45.0,
//           child: Text(text, style: TextStyle(color: Colors.white)),
//         ),
//       ),
//     );
//   }
// }