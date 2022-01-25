import 'package:biofuture/model/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostService {
  List<PostModel> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PostModel(
        id: doc.id,
        text: (doc.data() as dynamic)['text'] ?? '',
        creator: (doc.data() as dynamic)['creator'] ?? '',
        timestamp: (doc.data() as dynamic)['timestamp'] ?? 0,
      );
    }).toList();
  }

  Future savePost(text) async {
    await FirebaseFirestore.instance.collection("post").add({
      'text': text,
      'creator': FirebaseAuth.instance.currentUser!.uid,
      'timestamp': FieldValue.serverTimestamp()
    });
  }

  Stream<List<PostModel>> getPostByUser(uid) {
    return FirebaseFirestore.instance
        .collection("post")
        .where('creator', isEqualTo: uid)
        .snapshots()
        .map(_postListFromSnapshot);
  }

  Future<List<PostModel>> getFeed() async {
    //List<String> users =
    //await UserService().getuser(FirebaseAuth.instance.currentUser.uid);
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('post')
        //.where('creator', whereIn: usersFollowing)
        .orderBy('timestamp', descending: true)
        .get();
    return _postListFromSnapshot(querySnapshot);
  }
}
