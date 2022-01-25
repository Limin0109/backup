import 'package:biofuture/page/chat_room.dart';
import 'package:biofuture/page/research_menu.dart';
import 'package:biofuture/widgets/appbar_home.dart';
import 'package:biofuture/widgets/forumpage.dart';
import 'package:biofuture/widgets/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomepageBackUp(),
    );
  }
}

void main() => runApp(MyApp());

class HomepageBackUp extends StatefulWidget {
  @override
  _HomePageBackUpState createState() => _HomePageBackUpState();
}

class _HomePageBackUpState extends State<HomepageBackUp> {
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: appbarHome(context),
      backgroundColor: Colors.lightBlue[50],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ResearchCentreCard(context),
            SizedBox(height: 10),
            ForumCard(context),
            SizedBox(height: 10),
            ChatRoomCard(context),
          ],
        ),
      ),
    );
  }
}

Widget ResearchCentreCard(BuildContext context) => Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image: AssetImage(
              'lib/images/research.png',
            ),
            child: InkWell(onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ResearchMenu()));
            }),
            height: 210,
            fit: BoxFit.cover,
          ),
          Text(
            'Research Centre',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 40,
            ),
          )
        ],
      ),
    );

Widget ForumCard(BuildContext context) => Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image: AssetImage(
              'lib/images/forum.png',
            ),
            child: InkWell(onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Forumpage()));
            }),
            height: 210,
            fit: BoxFit.cover,
          ),
          Text(
            'Forum',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 40,
            ),
          )
        ],
      ),
    );

Widget ChatRoomCard(BuildContext context) => Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image: AssetImage(
              'lib/images/chatbox.png',
            ),
            child: InkWell(onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ChatRoom()));
            }),
            height: 210,
            fit: BoxFit.cover,
          ),
          Text(
            'Chat Room',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 40,
            ),
          )
        ],
      ),
    );
