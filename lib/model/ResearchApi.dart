import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {
  Future<void> addData(posData) async {
    print(posData);
    FirebaseFirestore.instance
        .collection("research_post")
        .add(posData)
        .then((value) => print(value))
        .catchError((e) {
      print(e);
    });
  }

  getData() async {
    return await FirebaseFirestore.instance.collection("research_post").get();
  }
}
