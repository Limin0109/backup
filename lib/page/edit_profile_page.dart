import 'dart:io';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:biofuture/model/api.dart';
import 'package:biofuture/model/user_model.dart';
import 'package:biofuture/page/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
//import 'package:biofuture/model/user.dart';
import 'package:biofuture/utils/user_preferences.dart';
import 'package:biofuture/widgets/appbar_widget.dart';
import 'package:biofuture/widgets/button_widget.dart';
import 'package:biofuture/widgets/profile_widget.dart';
import 'package:biofuture/widgets/textfield_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  File? pic;

  final nameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final aboutEditingController = new TextEditingController();

  /*
  late User user;

  @override
  void initState() {
    super.initState();

    user = UserPreferences.getUser();
  }*/

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

  @override
  Widget build(BuildContext context) => Scaffold(
        //child: Builder(
        // builder: (context) => Scaffold(
        appBar: buildAppBar(context),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          physics: BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 12),
            ProfileWidget(
              imagePath: "${loggedInUser.urlAvatar}",
              onClicked: ProfilePic,
              /*final image =
                    await ImagePicker().getImage(source: ImageSource.gallery);

                if (image == null) return;

                final directory = await getApplicationDocumentsDirectory();
                final name = basename(image.path);
                final imageFile = File('${directory.path}/$name');
                final newImage = await File(image.path).copy(imageFile.path);

                setState(() => 
                user = user.copy(imagePath: newImage.path));*/

              isEdit: true,
            ),
            const SizedBox(height: 24),
            /*TextFieldWidget(
              label: 'Full Name',
              text: user.name,
              onChanged: (name) => user = user.copy(name: name),
            ),*/
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: nameEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),
            /*TextFieldWidget(
              label: 'Email',
              text: user.email,
              onChanged: (email) => user = user.copy(email: email),
            ),*/
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: emailEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),
            /*TextFieldWidget(
              label: 'About',
              text: user.about,
              maxLines: 5,
              onChanged: (about) => user = user.copy(about: about),
            ),*/
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: aboutEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),
            ButtonWidget(
              text: 'Save',
              icon: Icons.save,
              onClicked: UpdateUser,
            ),
          ],
        ),
      );
  //),
  //);

  Future ProfilePic() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => pic = File(path));
  }

  Future UpdateUser() async {
    if (pic == null) return;

    final profilepic = basename(pic!.path);
    final destination = 'files/$profilepic';

    final task = FirebaseApi.uploadFile(destination, pic!);
    setState(() {});

    if (task == null) return;
    final snapshot = await task.whenComplete(() {});
    final String urlpic = await snapshot.ref.getDownloadURL();

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;
    UserModel userModel = UserModel();

    userModel.name = nameEditingController.text;
    userModel.about = aboutEditingController.text;
    userModel.email = emailEditingController.text;
    userModel.uid = user!.uid;
    userModel.urlAvatar = urlpic;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Navigator.pushAndRemoveUntil(
        (this.context),
        MaterialPageRoute(builder: (context) => ProfilePage()),
        (route) => false);
  }
}
