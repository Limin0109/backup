import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class CommentApi {
  Future<void> addData(CommentData) async {
    print(CommentData); //查看看posData是不是default的
    FirebaseFirestore.instance
        .collection("PostComments")
        .add(CommentData)
        .then((value) => print(value))
        .catchError((e) {
      print(e);
    });
  }

  getComment() async {
    return await FirebaseFirestore.instance.collection("PostComments").get();
  }
}
