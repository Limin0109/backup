//import 'dart:html';

//import 'dart:html';

import 'package:biofuture/model/CommentApi.dart';
import 'package:biofuture/model/ResearchApi.dart';
import 'package:biofuture/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//import 'package:http/http.dart';
import 'package:path/path.dart';
//import 'package:timeago/timeago.dart' as timeago;
//import 'package:firestore_collection/firestore_collection.dart';

final commentsRef = FirebaseFirestore.instance.collection('PostComments');
//FirebaseStorage.instance.Settings(Timestamp: true)
final auth = FirebaseAuth.instance;
UserModel loggedInUser = UserModel();
User? loginUser = FirebaseAuth.instance.currentUser;
//QuerySnapshot? snapshot;
bool? isLoading;
CommentApi commentApi = new CommentApi();
CrudMethods postid = CrudMethods();

class PostComments extends StatefulWidget {
  final String postID;
  final String author;
  final String title;
  final String desc;
  final String ncbi;
  final String github;
  final String imgURL;
  final String urlAvatar;
  final String pdffrontpage;

  PostComments({
    required this.postID,
    required this.author,
    required this.desc,
    required this.github,
    required this.imgURL,
    required this.ncbi,
    required this.pdffrontpage,
    required this.title,
    required this.urlAvatar,
  });

  @override
  PostCommentsState createState() => PostCommentsState(
        postID: this.postID,
        author: this.author,
        desc: this.desc,
        github: this.github,
        imgURL: this.imgURL,
        ncbi: this.ncbi,
        pdffrontpage: this.pdffrontpage,
        title: this.title,
        urlAvatar: this.urlAvatar,
      );
}

class PostCommentsState extends State<PostComments> {
  TextEditingController commentController = new TextEditingController();

  final String postID;
  final String author;
  final String title;
  final String desc;
  final String ncbi;
  final String github;
  final String imgURL;
  final String urlAvatar;
  final String pdffrontpage;

  PostCommentsState({
    required this.postID,
    required this.author,
    required this.desc,
    required this.github,
    required this.imgURL,
    required this.ncbi,
    required this.pdffrontpage,
    required this.title,
    required this.urlAvatar,
  });

  getCurrentUser() {
    final user = auth.currentUser;
    if (user != null) {
      loginUser = user;
    }
  }

  addComments() {
    /*
    commentsRef.doc(postID).collection('postcomment').add({
      "author": loggedInUser.name,
      "comment": commentController.text,
      "timestamp": Timestamp,
      "urlAvatar": loggedInUser.urlAvatar,
      "userID": loggedInUser.uid
    });*/
    Map<String, dynamic> CommentData = {
      "author": loggedInUser.name,
      "comment": commentController.text,
      "timestamp": Timestamp.now(),
      "urlAvatar": loggedInUser.urlAvatar,
      "userID": loggedInUser.uid,
    };

    commentApi.addData(CommentData).then((value) {
      setState(() {
        isLoading = false;
      });
    });

    commentController.clear();
  }

  buildComments() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('PostComments')
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
      /*stream: commentsRef
          .doc()
          .collection('PostComments')
          //.orderBy("timestamp", descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }*/
      //List<Comments> comments = [];
      //snapshot.forEach((doc) {
      // comments.add(PostComments.fromDocument(doc));
      //});
      //return ListView(
      // children: comments,
      //return commentget();
      //);
      //},
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
              child: Text("Post"),
            ),
          )
        ],
      ),
    );
  }

  final auth = FirebaseAuth.instance;
  CrudMethods postData = CrudMethods();
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

/*
Widget commentget() {
  return Container(
    child: ListView.builder(
      padding: EdgeInsets.all(5),
      itemCount: snapshot!.docs.length,
      itemBuilder: (context, index) {
        return Comments(
          author: snapshot!.docs[index].get('author'),
          userID: snapshot!.docs[index].get('userID'),
          comment: snapshot!.docs[index].get('comment'),
          timestamp: snapshot!.docs[index].get('timestamp'),
          urlAvatar: snapshot!.docs[index].get('urlAvatar'),
        );
      },
    ),
  );
}
*/
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
          //subtitle: Text(timeago.format(timestamp.toDate())),
        )
      ],
    );
  }
}
