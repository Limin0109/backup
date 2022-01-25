import 'package:biofuture/model/PostApi.dart';
import 'package:biofuture/model/user_model.dart';
import 'package:biofuture/page/ForumComment.dart';
import 'package:biofuture/page/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//var loginUser = FirebaseAuth.instance.currentUser;

class ForumPost extends StatefulWidget {
  /*final String post;
  final Timestamp timestamp;
  final String urlAvatar;
  final String user;

  ForumPost({
    required this.post,
    required this.timestamp,
    required this.urlAvatar,
    required this.user,
  });*/

  @override
  _ForumPostState createState() => _ForumPostState(
      /* post: this.post,
        timestamp: this.timestamp,
        urlAvatar: this.urlAvatar,
        user: this.user,*/
      );
}

class _ForumPostState extends State<ForumPost> {
  bool _hasBeenPressed = false;
  CrudMethodsForum crudMethodsForum = new CrudMethodsForum();
/*
  final String post;
  final Timestamp timestamp;
  final String urlAvatar;
  final String user;
*/
  /*_ForumPostState({
    required this.post,
    required this.timestamp,
    required this.urlAvatar,
    required this.user,
  });*/

  final auth = FirebaseAuth.instance;
  CrudMethodsForum postData = CrudMethodsForum();
  UserModel loggedInuser = UserModel();
  User? loginUser = FirebaseAuth.instance.currentUser;
  QuerySnapshot? snapshot;

  @override
  void initState() {
    /*FirebaseFirestore.instance
        .collection("Post")
        .doc(loginUser!.uid)
        .get()
        .then((value) {
      this.loggedInuser = UserModel.fromMap(value.data());
      setState(() {});
    });*/
    crudMethodsForum.getData().then((result) {
      setState(() {
        snapshot = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(2),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Post").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Forum();
        },
      ),
    );
  }

  Widget Forum() {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 24),
        itemCount: snapshot!.docs.length,
        itemBuilder: (context, index) {
          return OnePost(
            user: snapshot!.docs[index].get("user"),
            post: snapshot!.docs[index].get("post"),
            timestamp: snapshot!.docs[index].get("timestamp"),
            urlAvatar: snapshot!.docs[index].get("urlAvatar"),
          );
        },
      ),
    );
  }
}

class OnePost extends StatelessWidget {
  bool hasBeenPressed = false;
  final String user, post, urlAvatar;
  final Timestamp? timestamp;

  OnePost({
    required this.post,
    required this.timestamp,
    required this.urlAvatar,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    //final time = timestamp.toDate();
    //var date = DateTime.fromMillisecondsSinceEpoch(timestamp);

    return Container(
      margin: EdgeInsets.only(bottom: 14, right: 16, left: 16),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.28,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(children: <Widget>[
                  ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        ),
                      ]),
                      child: CircleAvatar(
                        child: ClipOval(
                          child: Image.network(
                            urlAvatar,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      user,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text("20:06pm"),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    post,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                              icon: new Icon(
                                Icons.favorite_rounded,
                              ),
                              color: hasBeenPressed
                                  ? Colors.teal
                                  : Colors.deepOrange[400],
                              onPressed: () => {
                                    hasBeenPressed != hasBeenPressed,
                                    print("Like post"),
                                  }),
                        ],
                      ),
                      const SizedBox(width: 5),
                      Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.chat),
                              iconSize: 30,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ForumComments()));
                              }),
                        ],
                      )
                    ],
                  ),
                ]))
          ],
        ),
      ),
    );

    /*Container(
      height: 760,
      margin: EdgeInsets.only(top: 10),
      width: double.infinity,
      color: Colors.grey[200],
      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    child: CircleAvatar(
                      child: ClipOval(
                        child: Image.network(
                          urlAvatar,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      user,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              )
            ],
          ),
          ConstrainedBox(
            constraints: new BoxConstraints(
              minHeight: 80,
              minWidth: 150,
              maxHeight: 600,
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: Container(
              margin: EdgeInsets.only(left: 30, top: 30, right: 30),
              child: Text(
                post,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Raleway',
                    color: Colors.black.withOpacity(1)),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 100),
                alignment: Alignment.center,
                height: 100,
                width: MediaQuery.of(context).size.width * 0.33,
                child: Container(
                  width: 50,
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 50,
                        child: IconButton(
                          icon: new Icon(
                            Icons.favorite_rounded,
                          ),
                          color: hasBeenPressed
                              ? Colors.teal
                              : Colors.deepOrange[400],
                          onPressed: () => {
                            hasBeenPressed = !hasBeenPressed,
                          },
                          //print('press');
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 100),
                alignment: Alignment.center,
                height: 100,
                width: MediaQuery.of(context).size.width * 0.33,
                child: Container(
                  width: 50,
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 50,
                        child: IconButton(
                          icon: new Icon(
                            Icons.add_comment,
                          ),
                          color: Colors.deepOrange[400],
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Comment()),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );*/
  }
}
