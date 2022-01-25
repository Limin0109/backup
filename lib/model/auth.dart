//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

var loginUser = FirebaseAuth.instance.currentUser;

class History extends StatefulWidget {
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final researchPost = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  getCurrentUser() {
    final user = auth.currentUser;
    if (user != null) {
      loginUser = user;
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text("User History"),
        ),
        backgroundColor: Colors.teal[50],
        body: SingleChildScrollView(
            physics: ScrollPhysics(),
            //reverse: true,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      //height: 540,
                      height: MediaQuery.of(context).size.height - 135,
                      child: SingleChildScrollView(
                          physics: ScrollPhysics(),
                          //reverse: true,
                          child: ShowData())),
                ])));
  }
}

class ShowData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("reseacrh_post")
          .orderBy("time")
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
            physics: ScrollPhysics(),
            itemBuilder: (context, i) {
              QueryDocumentSnapshot x = snapshot.data!.docs[i];
              return ListTile(
                  title: Column(
                crossAxisAlignment: loginUser!.email == x["user"]
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: loginUser!.email == x["user"]
                          ? Colors.blue.withOpacity(0.2)
                          : Colors.amber.withOpacity(0.4),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          x['title'],
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          x['postID'],
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          x['desc'],
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  )
                ],
              ));
            });
      },
    );
  }
}
