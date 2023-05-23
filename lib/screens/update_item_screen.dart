import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csed_inventory/screens/admin_dashboard_screen.dart';
import 'package:csed_inventory/screens/qr_scanner_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class UpdateItemScreen extends StatefulWidget {
  final String documentId;
  final Map<String, dynamic> data;

  const UpdateItemScreen(
      {Key? key, required this.documentId, required this.data})
      : super(key: key);

  @override
  State<UpdateItemScreen> createState() => _UpdateItemScreenState();
}

class _UpdateItemScreenState extends State<UpdateItemScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('item');
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> initialData = {};

  bool _isLoading = false;

  TextEditingController dateController = TextEditingController();
  TextEditingController billnoController = TextEditingController();
  TextEditingController supplieraddresscontroller = TextEditingController();
  TextEditingController specificationController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController suppliersemailController = TextEditingController();
  TextEditingController supplierscontactController = TextEditingController();
  TextEditingController warrantystatusController = TextEditingController();
  TextEditingController fundedbyController = TextEditingController();
  // TextEditingController totalamountController = TextEditingController();
  double ? result =0,num1 = 0,num2=0;

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
  void initState() {
    setState(() {
      initialData = widget.data;
    });
    dateController.text = initialData['date'];
    billnoController.text = initialData['billno'];
    supplieraddresscontroller.text = initialData['suppliers_address'];
    specificationController.text = initialData['specification'];
    rateController.text = initialData['rate'];
    quantityController.text = initialData['quantity'];
    remarksController.text = initialData['remarks'];
    suppliersemailController.text = initialData['suppliers_email'];
    supplierscontactController.text = initialData['suppliers_contact'];
    warrantystatusController.text = initialData['warranty_status'];
    fundedbyController.text = initialData['fundedby'];
    //totalamountController.text = initialData['total_amount'];
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
          dateController.text = value as String;
        },
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
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
          if (value!.isEmpty) {
            return (" This field is required!");
          }
          // if (!regExp.hasMatch(value)) {
          //   return ("Please enter valid name of 3 character");
          // }
          return null;
        },
        onSaved: (value) {
          billnoController.text = value!;
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

    final suppliersAddressfield = TextFormField(
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
          supplieraddresscontroller.text = value!;
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
          suppliersemailController.text = value!;
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
          supplierscontactController.text = value!;
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
          warrantystatusController.text = value!;
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
            return (" This field is required!");
          }

          return null;
        },
        onSaved: (value) {
          specificationController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.add_shopping_cart_outlined),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Specification",
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
          fundedbyController.text = value!;
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
          rateController.text = value!;
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
          quantityController.text = value!;
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

    // final totalAmountfield = TextFormField(
    //     autofocus: false,
    //     controller: totalamountController,
    //     keyboardType: TextInputType.number,
    //     onSaved: (value) {
    //       totalamountController.text = value!;
    //     },
    //     validator: (value) {
    //       if (value!.isEmpty) {
    //         return (" This field is required!");
    //       }
    //       return null;
    //     },
    //     textInputAction: TextInputAction.next,
    //     decoration: InputDecoration(
    //       prefixIcon: const Icon(Icons.monetization_on_outlined),
    //       contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
    //       hintText: "Total Amount",
    //       border: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(1),
    //       ),
    //     ));
    final CalculateButton = MaterialButton(
      elevation: 5,
      color: Colors.deepPurple,
      onPressed: () {
        multiply();
      },
      child: const Text(
        "click to calculate and save",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white,fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );

    final remarksField = TextFormField(
        autofocus: false,
        controller: remarksController,
        keyboardType: TextInputType.text,
        onSaved: (value) {
          remarksController.text = value!;
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

    final UpdateButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Colors.deepPurple,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () async {
            //signUp(emailEditingController.text, passwordEditingController.text);
            // update();
            if (!_formKey.currentState!.validate()) {
              return;
            } else {
              final docItem = itemCollection.doc(widget.documentId);
              await docItem.update({
                'date': dateController.text,
                'billno': billnoController.text,
                'suppliers_address': supplieraddresscontroller.text,
                'specification': specificationController.text,
                'rate': rateController.text,
                'quantity': quantityController.text,
                'remarks': remarksController.text,
                'warranty_status': warrantystatusController.text,
                'suppliers_contact': supplierscontactController.text,
                'suppliers_email': suppliersemailController.text,
                'fundedby': fundedbyController.text,
                'total_amount': result,
              });
              Fluttertoast.showToast(msg: "Item updated successfully");
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => AdminDashboardScreen()),
                (Route<dynamic> route) => false,
              );
            }
          },
          child: const Text(
            "Update Item",
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
              padding: const EdgeInsets.only(top: 180.0),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 36, right: 36),
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
                        suppliersAddressfield,
                        const SizedBox(height: 20),
                        suppliersEmailField,
                        const SizedBox(height: 20),
                        suppliersContactField,
                        const SizedBox(height: 20),
                        specificationField,
                        const SizedBox(height: 20),
                        fundedByField,
                        const SizedBox(height: 20),
                        rateField,
                        const SizedBox(height: 20),
                        quantityField,
                        const SizedBox(height: 20),
                        // totalAmountfield,
                        // const SizedBox(height: 20),
                        warrantyStatusField,
                        const SizedBox(height: 20),
                        CalculateButton,
                        const SizedBox(height: 20),
                        remarksField,
                        const SizedBox(height: 40),
                        UpdateButton,
                        const SizedBox(height: 30),
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
}
