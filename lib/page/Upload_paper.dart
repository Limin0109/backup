// ignore: file_names
//import 'dart:html';
//import 'dart:js';
import 'dart:developer';

import 'package:biofuture/model/ResearchApi.dart';
import 'package:biofuture/page/FrontPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:biofuture/model/api.dart';
import 'package:biofuture/widgets/appbar_research.dart';
import 'package:biofuture/widgets/button_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
//import 'package:biofuture/widgets/ButtonWidget.dart';
import 'dart:io';
import 'package:biofuture/model/user_model.dart';
import 'package:uuid/uuid.dart';

class UploadPaper extends StatefulWidget {
  @override
  _UploadPaperState createState() => _UploadPaperState();
}

class _UploadPaperState extends State<UploadPaper> {
  bool value = false;
  UploadTask? task;
  File? file;
  //File? image;
  bool isLoading = false;
  CrudMethods crudMethods = new CrudMethods();

  TextEditingController titleTextEditingController =
      new TextEditingController();
  TextEditingController descTextEditingController = new TextEditingController();
  TextEditingController ncbiTextEditingController = new TextEditingController();
  TextEditingController githubTextEditingController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return Scaffold(
      appBar: appbarResearch(context),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 5),
          TitleWidget(),
          const SizedBox(height: 8),
          DescriptionWidget(),
          const SizedBox(height: 8),
          Text('Attachment(.pdf, .jpg, .png, etc..'),
          AttachmentWidget(),
          const SizedBox(height: 8),
          //Text('Attach your own pdf front page(.jpg, .png)'),
          //FrontPage(),
          //const SizedBox(height: 8),
          Text(
            fileName,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Text('Website/NCBI'),
          TextField(
            controller: ncbiTextEditingController,
            decoration: InputDecoration(
              hintText: '(optional)',
            ),
          ),
          const SizedBox(height: 8),
          Text('GitHub/Gitlab'),
          TextField(
            controller: githubTextEditingController,
            decoration: InputDecoration(
              hintText: '(optional)',
            ),
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
              title: Text(
                'If you are a UTM student or UTM researcher.',
              ),
              value: this.value,
              onChanged: (bool? value) {
                setState(() {
                  this.value = value!;
                });
              }),
          const SizedBox(height: 10),
          ButtonWidget(
            text: 'Submit',
            onClicked: uploadFile,
            icon: Icons.cloud_upload,
          ),
        ],
      ),
    );
  }

  Widget TitleWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
          child: TextField(
            controller: titleTextEditingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Title..',
            ),
          ),
        ),
      ],
    );
  }

  Widget DescriptionWidget() {
    late final TextEditingController controller;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 3),
          TextField(
            controller: descTextEditingController,
            maxLines: 8,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: '(Optional)',
            ),
          ),
        ],
      ),
    );
  }

  Widget AttachmentWidget() {
    return ButtonWidget(
      text: 'Upload',
      icon: Icons.attach_file,
      onClicked: selectFile,
    );
  }

/*
  Widget FrontPage() {
    return ButtonWidget(
      text: 'FrontPage',
      icon: Icons.attach_file_rounded,
      onClicked: selectFile,
    );
  }
*/
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    //final result2 = await FilePicker.platform.pickFiles(
    //   allowMultiple: false, allowedExtensions: ['jpg', 'png', 'jpeg']);

    if (result == null) return;
    //if (result2 == null) return;
    final path = result.files.single.path!;
    //final path2 = result2.files.single.path!;

    setState(() => file = File(path));
    //setState(() => image = File(path2));
  }

  Future uploadFile() async {
    if (file == null) return;
    // if (image == null) return;

    final fileName = basename(file!.path);
    // final imageName = basename(image!.path);
    final destination = 'files/$fileName';
    // final destination2 = 'image/$imageName';

    final task = FirebaseApi.uploadFile(destination, file!);
    // final task2 = FirebaseApi.uploadFile(destination2, image!);
    setState(() {});

    if (task == null) return;

    var uuid = Uuid();

    final snapshot = await task.whenComplete(() {});
    final String urlDownload = await snapshot.ref.getDownloadURL();
    final String postID = uuid.v4();
/*
    Map<String, dynamic> posData = {
      'imgURL': urlDownload,
      'author': loggedInUser.name,
      'urlAvatar': loggedInUser.urlAvatar,
      'title': titleTextEditingController.text,
      'desc': descTextEditingController.text,
      'ncbi': ncbiTextEditingController.text,
      'github': githubTextEditingController.text,
      'postID': postID,
      'pdffrontpage': "",
    };

    crudMethods.addData(posData).then((value) {
      setState(() {
        isLoading = false;
      });
    });
*/
    print('Download-Link: $urlDownload');

    Navigator.of(this.context).push(MaterialPageRoute(
        builder: (context) => FrontPage(
              url: urlDownload,
              title: titleTextEditingController.text,
              desc: descTextEditingController.text,
              ncbi: ncbiTextEditingController.text,
              github: githubTextEditingController.text,
              id: postID,
            )));
    /* Navigator.pushNamed(this.context, FrontPage.route, arguments: {
      urlDownload,
      titleTextEditingController.text,
      descTextEditingController.text,
      ncbiTextEditingController.text,
      githubTextEditingController.text,
      postID,
    });*/
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
  Service service = Service();

  final auth = FirebaseAuth.instance;
  UserModel loggedInUser = UserModel();
  User? loginUser = FirebaseAuth.instance.currentUser;

  getCurrentUser() {
    final user = auth.currentUser;
    if (user != null) {
      loginUser = user;
    }
  }
/*
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
  }*/
}
