import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csed_inventory/screens/update_item_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'admin_dashboard_screen.dart';

class GetItem extends StatelessWidget {
  final String documentId;

  GetItem(this.documentId);

  void searchFromFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('item')
        .where('billno', isEqualTo: query)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    print("code will start from here ");
    CollectionReference itemCollection =
        FirebaseFirestore.instance.collection('item');

    print("Code will stop here ");

    return FutureBuilder<DocumentSnapshot>(
      future: itemCollection.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        //Error Handling conditions
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Center(child: Text("Document does not exist"));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Container(
                  // height: 500,
                  color: Colors.lightBlue.shade50,
                  padding:
                      EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Item Details:',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'Date: ${data['date']}',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Bill no.: ${data['billno']}',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Suppliers Address: ${data['suppliers_address']}',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Suppliers Contact: ${data['suppliers_contact']}',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Suppliers Email: ${data['suppliers_email']}',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Specification: ${data['specification']}',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Warranty Status: ${data['warranty_status']}',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Fund Allocated From: ${data['fundedby']}',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'One Item Price: ${data['rate']}',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Total Quantity: ${data['quantity']}',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Total Amount: ${data['total_amount']}',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Remarks, If Any: ${data['remarks']}',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(
                        height: 0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdateItemScreen(
                                              documentId: documentId,
                                              data: data,
                                            )));
                              },
                              child: const Text("UPDATE")),
                          const SizedBox(
                            width: 60,
                            height: 180,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        child: AlertDialog(
                                          title: const Text(
                                              "Do you want to delete the Item?"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  itemCollection
                                                      .doc(documentId)
                                                      .delete();
                                                  Fluttertoast.showToast(
                                                      msg: "Item Deleted");
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const AdminDashboardScreen()),
                                                    (Route<dynamic> route) =>
                                                        false,
                                                  );
                                                },
                                                child: const Text("YES")),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("NO")),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: const Text("DELETE"))
                        ],
                      ),
                    ],
                  ),
                );
              });
        }

        return const Center(
          child: Text(
            "loading",
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
