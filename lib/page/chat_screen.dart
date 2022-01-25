import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

var loginUser = FirebaseAuth.instance.currentUser;

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Service service = Service();

  final storeMessage = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  TextEditingController msg = TextEditingController();
  

  getCurrentUser(){
    final user = auth.currentUser;
    if (user!=null){
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
        title: const Text("Message"),
      ),
      backgroundColor: Colors.teal[50],
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        //reverse: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              //height: 540,
              //height: MediaQuery.of(context).size.height - 50,
              height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + kToolbarHeight) - 55,
              child : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                //reverse: true,
                child: ShowMessages())
                ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.4), spreadRadius: 3),
                ],
              ),
              child: Row(
                children: [
                Expanded(child: 
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    child: TextField(
                      controller: msg,
                      decoration: InputDecoration(hintText: "Type a message"),
                    ),
                )),
                IconButton(
                  onPressed: (){
                    if (msg.text.isNotEmpty){
                      storeMessage.collection("Messages").doc().set({
                        "messages": msg.text.trim(),
                        "user": loginUser!.email.toString(),
                        "time": DateTime.now(),
                      });
                      msg.clear();
                    }
                  }, 
                  icon: Icon(
                    Icons.send, 
                    color: Colors.teal,))
              ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShowMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
        .collection("Messages")
        .orderBy("time")
        .snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          shrinkWrap: true,
          primary: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, i){
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
                      color: loginUser!.email ==x["user"]
                      ? Colors.blue.withOpacity(0.2)
                      : Colors.amber.withOpacity(0.4),
                    ),
                    child: Text(x["messages"])
                    )
                  ],
              )
            );
        });
      },
    );
  }
}