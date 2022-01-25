import 'package:biofuture/model/auth.dart';
import 'package:biofuture/model/user_model.dart';
import 'package:biofuture/page/HomepageBackUp.dart';
import 'package:biofuture/page/UserHistory.dart';
import 'package:biofuture/page/chat_room.dart';
import 'package:biofuture/page/login_screen.dart';
import 'package:biofuture/page/profile_page.dart';
import 'package:biofuture/page/research_menu.dart';
import 'package:biofuture/test/TestHistory.dart';
//import 'package:biofuture/model/usertestTwiiter.dart';
import 'package:biofuture/utils/user_preferences.dart';
import 'package:biofuture/widgets/forumpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBar createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
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

  Widget build(BuildContext context) {
    //final user = UserPreferences.getUser();
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("${loggedInUser.name}"),
            accountEmail: Text('${loggedInUser.email}'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  '${loggedInUser.urlAvatar}',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
          ListTile(
              leading: Icon(Icons.home),
              title: Text('Homepage'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomepageBackUp()));
              }),
          ListTile(
              leading: Icon(Icons.article),
              title: Text('Research Center'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ResearchMenu()));
              }),
          ListTile(
              leading: Icon(Icons.forum),
              title: Text('Forum'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Forumpage()));
              }),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Chatbox'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ChatRoom()));
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('History'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HistoryOnTest()));
            },
          ),
          Divider(),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              logout(context);
            },
          ),
        ],
      ),
    );
  }
}

Future<void> logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
}
