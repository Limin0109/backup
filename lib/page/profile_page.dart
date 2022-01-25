//import 'package:biofuture/model/ResearchApi.dart';
import 'package:biofuture/model/user_model.dart';
import 'package:biofuture/page/patreon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:biofuture/model/user.dart';
import 'package:biofuture/widgets/appbar_widget.dart';
import 'package:biofuture/widgets/button_widget.dart';
import 'package:biofuture/widgets/numbers_widget.dart';
import 'package:biofuture/widgets/profile_widget.dart';
import 'package:biofuture/utils/user_preferences.dart';
import 'package:biofuture/page/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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

  @override
  Widget build(BuildContext context) {
    //final user = UserPreferences.getUser();

    //return ThemeSwitchingArea(
    return Scaffold(
      //child: Builder(
      //builder: (context) => Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        //physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 12),
          ProfileWidget(
            imagePath: "${loggedInUser.urlAvatar}",
            onClicked: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              );
              setState(() {});
            },
          ),
          const SizedBox(height: 24),
          buildName(),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 24),
          NumbersWidget(),
          const SizedBox(height: 48),
          buildAbout(),
        ],
      ),
    );
    //)
    //);
  }

  Widget buildName() => Column(
        children: [
          Text(
            "${loggedInUser.name}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            "${loggedInUser.email}",
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Subscribe Patreon',
        icon: Icons.money,
        onClicked: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => SubscriptionList(),
            ),
          );
        },
      );

  Widget buildAbout() => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              "${loggedInUser.about}",
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
