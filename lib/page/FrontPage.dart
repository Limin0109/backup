// ignore: file_names
import 'dart:io';

import 'package:biofuture/model/ResearchApi.dart';
import 'package:biofuture/model/api.dart';
import 'package:biofuture/model/user_model.dart';
import 'package:biofuture/page/Upload_paper.dart';
import 'package:biofuture/page/research_menu.dart';
import 'package:biofuture/widgets/appbar_research.dart';
import 'package:biofuture/widgets/button_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class FrontPage extends StatefulWidget {
  String url;
  String title;
  String desc;
  String ncbi;
  String github;
  String id;

  FrontPage(
      {required this.url,
      required this.title,
      required this.desc,
      required this.ncbi,
      required this.github,
      required this.id});

  @override
  _FrontPage createState() => _FrontPage(
      url: this.url,
      title: this.title,
      desc: this.desc,
      ncbi: this.ncbi,
      github: this.github,
      id: this.id);
}

class _FrontPage extends State<FrontPage> {
  File? image;
  CrudMethods crudMethods = new CrudMethods();
  UploadTask? task;
  bool isLoading = false;
  //static const route = '/FrontPage';
  String url;
  String title;
  String desc;
  String ncbi;
  String github;
  String id;

  _FrontPage(
      {required this.url,
      required this.title,
      required this.desc,
      required this.ncbi,
      required this.github,
      required this.id});

  @override
  Widget build(BuildContext context) {
    final fileName = image != null ? basename(image!.path) : 'No File Selected';
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: appbarResearch(context),
      body: ListView(
        padding: EdgeInsets.all(20),
        physics: BouncingScrollPhysics(),
        children: [
          Text(
            'Custome your front page:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 15),
          displayGIF(),
          const SizedBox(height: 40),
          Text('Upload your front page (.jpg, .png ..): '),
          uploadFront(),
          const SizedBox(height: 5),
          Text(
            fileName,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),
          ButtonWidget(
            text: 'Submit',
            onClicked: uploadFile,
            icon: Icons.cloud_upload,
          )
        ],
      ),
    );
  }

  Widget displayGIF() {
    return Container(
      child: Image.asset('lib/images/frontPageGIF.gif'),
    );
  }

  Widget uploadFront() {
    return ButtonWidget(
      text: 'Select Image',
      icon: Icons.image_rounded,
      onClicked: selectImage,
    );
  }

  Future selectImage() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;

    final Imagepath = result.files.single.path!;

    setState(() => image = File(Imagepath));
  }

  Future uploadFile() async {
    if (image == null) return;

    final ImageName = basename(image!.path);
    final destination = 'frontpage/$ImageName';
    final task = FirebaseApi.uploadFile(destination, image!);

    setState(() {});

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    final FrontpageUrl = await snapshot.ref.getDownloadURL();

    Map<String, dynamic> posData = {
      'imgURL': url,
      'author': loggedInUser.name,
      'urlAvatar': loggedInUser.urlAvatar,
      'title': title,
      'desc': desc,
      'ncbi': ncbi,
      'github': github,
      'postID': id,
      'pdffrontpage': FrontpageUrl,
    };

    var collection = FirebaseFirestore.instance.collection('research_post');
    collection.doc(loginUser!.uid).update({'pdffrontpage': FrontpageUrl});

    crudMethods.addData(posData).then((value) {
      setState(() {
        isLoading = false;
      });
    });

    print('Image-Link: $FrontpageUrl');

    Navigator.of(this.context)
        .push(MaterialPageRoute(builder: (context) => ResearchMenu()));
  }

  final auth = FirebaseAuth.instance;
  UserModel loggedInUser = UserModel();
  User? loginUser = FirebaseAuth.instance.currentUser;
  getCurrentUser() {
    final user = auth.currentUser;
    if (user != null) {
      loginUser = user;
    }
  }

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
