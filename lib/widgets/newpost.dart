// ignore_for_file: deprecated_member_use

//import 'dart:html';
import 'dart:io';

//import 'package:biofuture/forum/forumpage.dart';
import 'package:biofuture/widgets/forumpage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//import 'package:biofuture/forum/postservice.dart';
//import 'package:biofuture/model/post.dart';
//import 'package:flutter_document_picker/flutter_document_picker.dart';
//import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:biofuture/model/user_model.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  UploadTask? task;
  File? file;

  final storeMessage = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  TextEditingController postTextEditingController = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  //final PostService _postService = PostService();
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height * 0.32,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        child: CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                NetworkImage("${loggedInUser.urlAvatar}")),
                        margin: EdgeInsets.only(left: 25),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text("${loggedInUser.name}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  // There is a stupid bug here, cannot more than 6 lines i think,
                  // tried to let the text in the container be able to scroll
                  // but cannot. https://www.geeksforgeeks.org/flutter-scrollable-text/
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    width: 300,
                    child: Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        reverse: true,
                        child: TextFormField(
                          minLines: 1,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          controller: postTextEditingController,
                          decoration: InputDecoration(
                              hintText: "What's on your mind?",
                              border: InputBorder.none),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        //margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.60,
                        child: Container(
                          width: 100,
                          child: Row(children: [
                            Container(
                              alignment: Alignment.center,
                              width: 50,
                              child: IconButton(
                                icon: new Icon(Icons.document_scanner),
                                color: Colors.deepOrange[400],
                                onPressed: () async {
                                  final result =
                                      await FilePicker.platform.pickFiles(
                                    allowMultiple: false,
                                    type: FileType.custom,
                                    allowedExtensions: ['pdf'],
                                  );

                                  if (result == null) return;
                                  final path = result.files.single.path!;

                                  setState(() => file = File(path));
                                },
                              ),
                            ),
                          ]),
                        ),
                      ),
                      Container(
                        //margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.36,
                        child: Container(
                          width: 100,
                          child: Row(children: [
                            Container(
                              alignment: Alignment.center,
                              width: 50,
                              child: IconButton(
                                icon: new Icon(Icons.image),
                                color: Colors.deepOrange[400],
                                onPressed: () async {
                                  final result =
                                      await FilePicker.platform.pickFiles(
                                    allowMultiple: false,
                                    type: FileType.custom,
                                    allowedExtensions: ['jpg', 'png', 'jpeg'],
                                  );

                                  if (result == null) return;
                                  final path = result.files.single.path!;

                                  setState(() => file = File(path));
                                },
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonTheme(
                        minWidth: 350.0,
                        height: 30,
                        child: FlatButton(
                          onPressed: () async {
                            //_postService.savePost('text');
                            if (postTextEditingController.text.isNotEmpty) {
                              storeMessage.collection("Post").doc().set({
                                "post": postTextEditingController.text.trim(),
                                "user": loggedInUser.name.toString(),
                                "urlAvatar": loggedInUser.urlAvatar.toString(),
                                'timestamp': FieldValue.serverTimestamp(),
                                //uploadFile(),
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Forumpage()));
                            }
                            //postTextEditingController.clear();
                            if (postTextEditingController.text.isEmpty) {
                              showAlertDialog(context);
                              /*
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Data is empty'),
                          ),
                        );*/
                            }
                          },
                          child: Text(
                            "Post",
                            style: TextStyle(fontSize: 20),
                          ),
                          color: Colors.blue,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(9.0),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ]));
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Forum Alert"),
    content:
        Text("Forum description should not be empty. Please add some text."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
