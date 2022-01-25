import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class CommentForumApi {
  Future<void> addData(CommentForumData) async {
    print(CommentForumData); //查看看posData是不是default的
    FirebaseFirestore.instance
        .collection("ForumComments")
        .add(CommentForumData)
        .then((value) => print(value))
        .catchError((e) {
      print(e);
    });
  }

  getComment() async {
    return await FirebaseFirestore.instance.collection("ForumComments").get();
  }
}
