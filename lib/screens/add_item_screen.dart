import 'dart:developer';

//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csed_inventory/screens/get_qrnumber_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('item');
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  //editing controller
  final dateController = TextEditingController();
  final billnoController = TextEditingController();
  final supplieraddresscontroller = TextEditingController();
  final specificationController = TextEditingController();
  final rateController = TextEditingController();
  final quantityController = TextEditingController();
  final totalamountController = TextEditingController();
  final remarksController = TextEditingController();
  final suppliersemailController = TextEditingController();
  final supplierscontactController = TextEditingController();
  final warrantystatusController = TextEditingController();
  final fundedbyController = TextEditingController();

  double? result = 0, num1 = 0, num2 = 0;

  String id = DateTime.now().microsecondsSinceEpoch.toString();

  multiply() {
    setState(
      () {
        num1 = double.parse(rateController.text);
        num2 = double.parse(quantityController.text);

        result = num1! * num2!;
        Fluttertoast.showToast(msg: "$result");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateField = TextFormField(
        autofocus: false,
        controller: dateController,
        validator: (value) {
          //RegExp regExp = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return (" This field is required!");
          }
          return null;
        },
        onSaved: (value) {
          //firstNameEditingController.text = value!;
        },
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1961),
              lastDate: DateTime.now());
          if (pickedDate != null) {
            setState(() {
              dateController.text = DateFormat('yyyy/MM/dd').format(pickedDate);
            });
          }
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.date_range_outlined),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Date",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ));

    final billnoField = TextFormField(
        autofocus: false,
        controller: billnoController,
        keyboardType: TextInputType.name,
        validator: (value) {
          // RegExp regExp = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return (" This field is required!");
          }
          // if (!regExp.hasMatch(value)) {
          //   return ("Please enter valid name of 3 character");
          // }
          return null;
        },
        onSaved: (value) {
          // firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.receipt_long_outlined),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Billno|Date",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ));

    final suppliersAddressField = TextFormField(
        autofocus: false,
        controller: supplieraddresscontroller,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return (" This field is required!");
          }
          return null;
        },
        onSaved: (value) {
          //firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.location_city_outlined),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Supplier's Address",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ));

    final suppliersEmailField = TextFormField(
        autofocus: false,
        controller: suppliersemailController,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Email of the Supplier!");
          }
          if (!RegExp("^[a-z0-9+_.-]+@[a-z]+.[a-z]").hasMatch(value)) {
            return ("Please enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          //firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email_outlined),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Supplier's Email Address",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ));

    final suppliersContactField = TextFormField(
        autofocus: false,
        controller: supplierscontactController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Contact Number of the Supplier!");
          } else if (!RegExp(
                  r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
              .hasMatch(value)) {
            return ("Please Enter Valid Contact Number!");
          }
          return null;
        },
        onSaved: (value) {
          //firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.contact_mail_outlined),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Supplier's Contact ",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ));

    final warrantyStatusField = TextFormField(
        autofocus: false,
        controller: warrantystatusController,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Warranty Details of Item!");
          }
          return null;
        },
        onSaved: (value) {
          //firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.details_outlined),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Warranty Details of Item",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ));

    final specificationField = TextFormField(
        autofocus: false,
        controller: specificationController,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Specify the item!");
          }
          return null;
        },
        onSaved: (value) {
          //firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.contact_mail_outlined),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Specification of Item",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ));

    final fundedByField = TextFormField(
        autofocus: false,
        controller: fundedbyController,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return (" This field is required!");
          }

          return null;
        },
        onSaved: (value) {
          //firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.add_shopping_cart_outlined),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Funded by",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ));

    final rateField = TextFormField(
        autofocus: false,
        controller: rateController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Price of the Item!");
          }
          return null;
        },
        onSaved: (value) {
          //firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.money),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "One Item Price",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ));

    final quantityField = TextFormField(
        autofocus: false,
        controller: quantityController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Quantity!");
          }
          return null;
        },
        onSaved: (value) {
          //quantityController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.countertops_outlined),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Total Quantity",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ));

    final CalculateButton = MaterialButton(
      elevation: 5,
      color: Colors.deepPurple,
      onPressed: () {
        multiply();
      },
      child: const Text(
        "click to calculate and save",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );

    final remarksField = TextFormField(
        autofocus: false,
        controller: remarksController,
        keyboardType: TextInputType.text,
        onSaved: (value) {
          //remarksController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.note),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Remarks, If Any",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ));

    final AddButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Colors.deepPurple,
      child: MaterialButton(
          minWidth: 150,
          onPressed: () {
            //addItem();
            if (!_formKey.currentState!.validate()) {
              return;
            } else {
              setState(() {
                _isLoading = true;
              });
              itemCollection.doc(id).set({
                'date': dateController.text,
                'billno': billnoController.text,
                'suppliers_address': supplieraddresscontroller.text,
                'specification': specificationController.text,
                'rate': rateController.text,
                'quantity': quantityController.text,
                'total_amount': result,
                'qrcodeno': id,
                'remarks': remarksController.text,
                'warranty_status': warrantystatusController.text,
                'suppliers_contact': supplierscontactController.text,
                'suppliers_email': suppliersemailController.text,
                'fundedby': fundedbyController.text,
              }).then((value) async {
                // reset the form
                dateController.clear();
                billnoController.clear();
                supplieraddresscontroller.clear();
                specificationController.clear();
                rateController.clear();
                quantityController.clear();
                totalamountController.clear();
                remarksController.clear();
                warrantystatusController.clear();
                supplierscontactController.clear();
                suppliersemailController.clear();
                fundedbyController.clear();

                Fluttertoast.showToast(msg: "Item added successfully");
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            GetQrNumberScreen(documentId: id)));
              }).catchError((error) {
                log(error.toString());
              });
            }
          },
          child: const Text(
            "Add Item",
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
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 36, right: 36),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 250,
                          child: Image.asset("assets/welcome.png"),
                        ),
                        dateField,
                        const SizedBox(height: 20),
                        billnoField,
                        const SizedBox(height: 20),
                        fundedByField,
                        const SizedBox(height: 20),
                        suppliersAddressField,
                        const SizedBox(height: 20),
                        suppliersEmailField,
                        const SizedBox(height: 20),
                        suppliersContactField,
                        const SizedBox(height: 20),
                        specificationField,
                        const SizedBox(height: 20),
                        warrantyStatusField,
                        const SizedBox(height: 20),
                        rateField,
                        const SizedBox(height: 20),
                        quantityField,
                        const SizedBox(height: 20),
                        CalculateButton,
                        const SizedBox(height: 20),
                        remarksField,
                        const SizedBox(height: 40),
                        AddButton,
                        const SizedBox(height: 30),
                        //GetQrNumber,
                        //const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

// void addItem() async {
//   if (_formKey.currentState!.validate()) {
//
//   }
// }
}
