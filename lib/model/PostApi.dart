import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethodsForum {
  Future<void> addData(posData) async {
    print(posData);
    FirebaseFirestore.instance
        .collection("Post")
        .add(posData)
        .then((value) => print(value))
        .catchError((e) {
      print(e);
    });
  }

  getData() async {
    return await FirebaseFirestore.instance.collection("Post").get();
  }
}
