//import 'package:biofuture/appbarhis.dart';
import 'package:biofuture/widgets/appbar_home.dart';
import 'package:biofuture/widgets/appbarhis.dart';
import 'package:biofuture/widgets/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

//import 'package:biofuture/UserModel.dart';

class UserHistory extends StatefulWidget {
  @override
  _UserHistoryState createState() => _UserHistoryState();
}

class _UserHistoryState extends State<UserHistory> {
  final firestoreref = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: appbarHis(context),
      body: SafeArea(
          child: FutureBuilder<QuerySnapshot>(
              future: firestoreref.collection("research_post").get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> arrData = snapshot.data!.docs;
                  return ListView(
                    children: arrData.map((data) {
                      return Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['title'],
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              data['postID'],
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              data['desc'],
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );

                  return Text('Data Found');
                } else {
                  return Text("data Not Found");
                }
              })),
    );
  }
}
