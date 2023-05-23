// import 'package:flutter/material.dart';
// import 'package:project/crloginDB.dart';
// import 'package:project/loginDatabase.dart';
// import 'package:project/main.dart';
// import 'VALIDATEResgister.dart';
// import 'Alter.dart';
// import 'signUpDb.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// validateData object = new validateData();
// SignUpDatabase dbConnection = new SignUpDatabase();
//
// class MyApp extends StatelessWidget {
// // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: signup(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// /*callback()
//   {
//     print("You are registered\n");
//   }*/
// }
//
// DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
//       value: item,
//       child: Text(
//         item,
//         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//       ),
//     );
//
// class signup extends StatefulWidget {
//   @override
//   _signupState createState() => _signupState();
// }
//
// class _signupState extends State<signup> {
//   late String email;
//   late String createPassword;
//   late String confirmPassword;
//   late String name;
//   late String fname;
//   late String number;
//   bool _obscureText = true;
//   late String user;
//   String groupValue = "CR";
//   final _formkey = GlobalKey<FormState>();
//   final admissionYear = ['2020', '2021', '2022'];
//   String? admissionValue;
//
//   valueChanged(e) {
//     setState(() {
//       if (e == "CR") {
//         groupValue = e;
//         user = e;
//       } else if (e == "STUDENT") {
//         groupValue = e;
//         user = e;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text("Registration Form")),
//         body: Stack(
//           children: <Widget>[
//             Form(
//               key: _formkey,
//               child: ListView(
//                 children: <Widget>[
//                   Padding(padding: const EdgeInsets.only(top: 10)),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextField(
//                       keyboardType: TextInputType.text,
//                       onChanged: (value) => name = value,
//                       decoration: InputDecoration(
//                         labelText: "Enter Your Full Name...",
//                         labelStyle: TextStyle(fontWeight: FontWeight.bold),
//                         icon: Icon(Icons.person),
//                       ),
//                     ),
//                   ),
//
//                   Padding(padding: const EdgeInsets.only(top: 10)),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextField(
//                       keyboardType: TextInputType.text,
//                       onChanged: (value) => fname = value,
//                       decoration: InputDecoration(
//                         labelText: "Enter Your Roll Number...",
//                         labelStyle: TextStyle(fontWeight: FontWeight.bold),
//                         icon: Icon(Icons.person),
//                       ),
//                     ),
//                   ),
//                   Padding(padding: const EdgeInsets.only(top: 10)),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextField(
//                       keyboardType: TextInputType.emailAddress,
//                       onChanged: (value) => email = value,
//                       decoration: InputDecoration(
//                         labelText: "Enter Your Email...",
//                         labelStyle: TextStyle(fontWeight: FontWeight.bold),
//                         icon: Icon(Icons.email),
//                       ),
//                     ),
//                   ),
//                   Padding(padding: const EdgeInsets.only(top: 10)),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextField(
//                       keyboardType: TextInputType.number,
//                       onChanged: (value) => number = value,
//                       decoration: InputDecoration(
//                         labelText: "Enter Your Mobile Number...",
//                         labelStyle: TextStyle(fontWeight: FontWeight.bold),
//                         icon: Icon(Icons.call),
//                       ),
//                     ),
//                   ),
//                   Padding(padding: const EdgeInsets.only(top: 10)),
//
//                   Row(children: <Widget>[
//                     Text("   User\n   Type",
//                         style: TextStyle(
//                             fontSize: 15, fontWeight: FontWeight.bold)),
//                     Expanded(
//                       child: ListTile(
//                         title: Text(
//                           "CR",
//                           textAlign: TextAlign.end,
//                         ),
//                         trailing: Radio(
//                             value: "CR",
//                             groupValue: groupValue,
//                             onChanged: (e) => valueChanged(e)),
//                       ),
//                     ),
//                     Expanded(
//                       child: ListTile(
//                         title: Text(
//                           "STUDENT",
//                           textAlign: TextAlign.end,
//                         ),
//                         trailing: Radio(
//                             value: "STUDENT",
//                             groupValue: groupValue,
//                             onChanged: (e) => valueChanged(e)),
//                       ),
//                     ),
//                   ]),
//
// //Padding(padding: const EdgeInsets.only(top: 10)),
// /* Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextField(
//                       keyboardType: TextInputType.number,
//                       onChanged: (value) => mname = value,
//                       decoration: InputDecoration(
//                         labelText: "Enter Semester Number...",
//                         icon: Icon(Icons.numbers_outlined),
//                       ),
//                     ),
//                   ),*/
//                   Container(
// //  width: 300,
//                     margin: EdgeInsets.all(16),
//                     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(color: Colors.black, width: 2)),
//                     child: SingleChildScrollView(
//                       child: DropdownButton<String>(
//                         value: admissionValue,
//                         iconSize: 36,
//                         icon: Icon(Icons.arrow_drop_down, color: Colors.black),
//                         isExpanded: true,
//                         underline: SizedBox(),
//                         hint: Text(
//                           "Select Admission Year",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         items: admissionYear.map(buildMenuItem).toList(),
//                         onChanged: (value) =>
//                             setState(() => this.admissionValue = value),
//                       ),
//                     ),
//                   ),
//
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       autocorrect: false,
//                       obscureText: _obscureText,
//                       onChanged: (value) => createPassword = value,
//                       decoration: InputDecoration(
//                         labelText: "Create Password...",
//                         labelStyle: TextStyle(fontWeight: FontWeight.bold),
//                         icon: Icon(Icons.lock),
//                         suffixIcon: IconButton(
//                           icon: Icon(
// // Based on passwordVisible state choose the icon
//                             _obscureText
//                                 ? Icons.visibility
//                                 : Icons.visibility_off,
//                             color: Theme.of(context).primaryColorLight,
//                           ),
//                           onPressed: () {
// // Update the state i.e. toogle the state of passwordVisible variable
//                             setState(() {
//                               _obscureText = !_obscureText;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       autocorrect: false,
//                       obscureText: _obscureText,
//                       onChanged: (value) => confirmPassword = value,
//                       decoration: InputDecoration(
//                         labelText: "Confirm Password...",
//                         labelStyle: TextStyle(fontWeight: FontWeight.bold),
//                         icon: Icon(Icons.lock),
//                         suffixIcon: IconButton(
//                           icon: Icon(
// // Based on passwordVisible state choose the icon
//                             _obscureText
//                                 ? Icons.visibility
//                                 : Icons.visibility_off,
//                             color: Theme.of(context).primaryColorLight,
//                           ),
//                           onPressed: () {
// // Update the state i.e. toogle the state of passwordVisible variable
//
//                             setState(() {
//                               _obscureText = !_obscureText;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                   Button(
//                       text: 'Register',
//
// //  key:
//                       callback: () async {
//                         if (name == null ||
//                             fname == null ||
//                             email == null ||
//                             number == null ||
//                             admissionValue == null ||
//                             createPassword == null ||
//                             confirmPassword == null) {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return CustomAlertDialog(
//                                 title: '*Required!!',
//                                 message:
//                                     'All Field are required.\n Please fill all the fields',
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               );
//                             },
//                           );
//                         } else if (object.check(name) == false) {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return CustomAlertDialog(
//                                 title: 'Wrong name!!',
//                                 message:
//                                     'Please use only small and capital letters or space only.\nFor Example "Ashutosh Agnihotri"',
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               );
//                             },
//                           );
//                         } else if (object.RN(fname) == false) {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return CustomAlertDialog(
//                                 title: 'Wrong RollNumber!!',
//                                 message:
//                                     'Please use correct roll number format.\nFor Example "M200685CA\m200685ca"',
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               );
//                             },
//                           );
//                         } else if (object.checkEmail(email) == false) {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return CustomAlertDialog(
//                                 title: 'Wrong Email!!',
//                                 message:
//                                     'Please use nitc email id.\nFor Example "ashutosh_m200685ca&nitc.ac.in"',
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               );
//                             },
//                           );
//                         } else if (object.checkMoreOnEmail(
//                                 email, name, fname) ==
//                             false) {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return CustomAlertDialog(
//                                 title: 'Wrong Email Format!!',
//                                 message:
//                                     'Please use correct email format.\nFor Example "firstName_rollNumber@nitc.ac.in"',
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               );
//                             },
//                           );
//                         } else if (object.checkPhone(number) == false) {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return CustomAlertDialog(
//                                 title: 'Wrong phoneNumber!!',
//                                 message:
//                                     'Please use 10 digit phone number.\n Start with any of these digits like 6,7,8,9',
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               );
//                             },
//                           );
//                         } else if (object.checkpass(createPassword) == false) {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return CustomAlertDialog(
//                                 title: 'Wrong format!!',
//                                 message:
//                                     'Please use at least 6 length password.',
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               );
//                             },
//                           );
//                         } else if (object.validatePass(
//                                 createPassword, confirmPassword) ==
//                             false) {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return CustomAlertDialog(
//                                 title: 'Something Missmatch!!',
//                                 message:
//                                     'Please make password and confirm password as same.',
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               );
//                             },
//                           );
//                         } else if (groupValue == 'CR') {
//                           crloginDB checkAdmissionYear = new crloginDB();
//                           Future<bool> exists = checkAdmissionYear
//                               .serachAdmissionYear(admissionValue);
//                           bool x = await exists;
//                           if (x == true) {
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return CustomAlertDialog(
//                                   title: 'Already Registered!!',
//                                   message: 'CR has already Registered.',
//                                   onPressed: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => HomePage()));
//                                   },
//                                 );
//                               },
//                             );
//                           } else {
//                             name = name.toUpperCase();
//                             fname = fname.toUpperCase();
//                             email = email.toLowerCase();
//                             print(name);
//                             print(fname);
//                             print(email);
//                             print(groupValue);
//                             print("Good to go");
//                             dbConnection.createRecord(
//                                 name,
//                                 fname,
//                                 email,
//                                 number,
//                                 groupValue,
//                                 admissionValue,
//                                 createPassword);
//
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return CustomAlertDialog(
//                                   title: 'Registered!!',
//                                   message: 'You are registered successfully.',
//                                   onPressed: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => HomePage()));
//                                   },
//                                 );
//                               },
//                             );
//                           }
//                         } else {
//                           name = name.toUpperCase();
//                           fname = fname.toUpperCase();
//                           email = email.toLowerCase();
//                           loginDatabase checkEmail = new loginDatabase();
//                           Future<bool> exists =
//                               checkEmail.serachEmailInStudents(email);
//                           bool x = await exists;
//                           if (x == true) {
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return CustomAlertDialog(
//                                   title: 'Already Exists!!',
//                                   message:
//                                       'You already registered with this email id.',
//                                   onPressed: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => HomePage()));
//                                   },
//                                 );
//                               },
//                             );
//                           } else {
//                             print(name);
//                             print(fname);
//                             print(email);
//                             print(groupValue);
//                             print("Good to go");
//                             dbConnection.createRecord(
//                                 name,
//                                 fname,
//                                 email,
//                                 number,
//                                 groupValue,
//                                 admissionValue,
//                                 createPassword);
//
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return CustomAlertDialog(
//                                   title: 'Registered!!',
//                                   message: 'You are registered successfully.',
//                                   onPressed: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => HomePage()));
//                                   },
//                                 );
//                               },
//                             );
//                           }
//                         }
//                         print("You are registered successfully\n");
//                       },
//                       key: Key("call"))
//                 ],
//               ),
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
//   const Button({required Key key, required this.callback, required this.text})
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
//           minWidth: 200.0,
//           height: 45.0,
//           child: Text(text, style: TextStyle(color: Colors.white)),
//         ),
//       ),
//     );
//   }
// }
