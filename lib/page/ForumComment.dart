//import 'dart:html';

//import 'dart:html';

import 'package:biofuture/model/CommentForumApi.dart';
import 'package:biofuture/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//import 'package:http/http.dart';
import 'package:path/path.dart';
//import 'package:timeago/timeago.dart' as timeago;
//import 'package:firestore_collection/firestore_collection.dart';

final commentsRef = FirebaseFirestore.instance.collection('ForumComments');
//FirebaseStorage.instance.Settings(Timestamp: true)
final auth = FirebaseAuth.instance;
UserModel loggedInUser = UserModel();
User? loginUser = FirebaseAuth.instance.currentUser;
//QuerySnapshot? snapshot;
bool? isLoading;
CommentForumApi commentForumApi = new CommentForumApi();
//CrudMethods postid = CrudMethods();

class ForumComments extends StatefulWidget {
  @override
  ForumCommentsState createState() => ForumCommentsState();
}

class ForumCommentsState extends State<ForumComments> {
  TextEditingController commentController = new TextEditingController();

  getCurrentUser() {
    final user = auth.currentUser;
    if (user != null) {
      loginUser = user;
    }
  }

  addComments() {
    Map<String, dynamic> CommentData = {
      "author": loggedInUser.name,
      "comment": commentController.text,
      "timestamp": Timestamp.now(),
      "urlAvatar": loggedInUser.urlAvatar,
      "userID": loggedInUser.uid,
    };

    commentForumApi.addData(CommentData).then((value) {
      setState(() {
        isLoading = false;
      });
    });

    commentController.clear();
  }

  buildComments() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('ForumComments')
          .orderBy("timestamp")
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          shrinkWrap: true,
          primary: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, i) {
            QueryDocumentSnapshot x = snapshot.data!.docs[i];
            return Comments(
              author: snapshot.data!.docs[i].get('author'),
              userID: snapshot.data!.docs[i].get('userID'),
              comment: snapshot.data!.docs[i].get('comment'),
              timestamp: snapshot.data!.docs[i].get('timestamp'),
              urlAvatar: snapshot.data!.docs[i].get('urlAvatar'),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        backgroundColor: Colors.lightBlue[100],
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: buildComments()),
          Divider(),
          ListTile(
            title: TextFormField(
              controller: commentController,
              decoration: InputDecoration(labelText: "Write your comments..."),
            ),
            trailing: OutlineButton(
              onPressed: addComments,
              borderSide: BorderSide.none,
              child: Text("Comment"),
            ),
          )
        ],
      ),
    );
  }

  final auth = FirebaseAuth.instance;
  // CrudMethods postData = CrudMethods();
  UserModel loggedInUser = UserModel();
  User? loginUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(loginUser!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
}

class Comments extends StatelessWidget {
  final String author;
  final String userID;
  final String urlAvatar;
  final String comment;
  final Timestamp timestamp;

  Comments({
    required this.author,
    required this.userID,
    required this.comment,
    required this.timestamp,
    required this.urlAvatar,
  });

  factory Comments.fromDocument(DocumentSnapshot doc) {
    return Comments(
      author: doc['author'],
      userID: doc['userID'],
      comment: doc['comment'],
      timestamp: doc['timestamp'],
      urlAvatar: doc['urlAvatar'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(author),
          subtitle: Text(comment),
          leading: CircleAvatar(
            child: Image.network(
              urlAvatar,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
