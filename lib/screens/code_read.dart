import 'package:cloud_firestore/cloud_firestore.dart';

class Search{
  List searchResult = [];
  Future<List> searchFromFirebase(String query) async {
    List searchResult =[];
    final result = await FirebaseFirestore.instance
        .collection('item')
        .where('billno', isEqualTo: query)
        .get();
    searchResult = result.docs.map((e) => e.data()).toList();
    for (int i=0;i<searchResult.length;i++){
      print(searchResult[i]);
    }
    return searchResult;
  }


}