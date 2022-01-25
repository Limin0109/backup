//import 'package:biofuture/model/navigation_item.dart';
import 'package:biofuture/widgets/appbar_home.dart';
import 'package:flutter/material.dart';
//import 'package:biofuture/page/my_drawer_header.dart';
//import 'package:flutter/src/widgets/framework.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
    );
  }
}

void main() => runApp(MyApp());

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarHome(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //we will add our widgets here
            SizedBox(height: 150),
            Container(
              color: Colors.blueGrey[100],
              width: 170,
              height: 170,
              child: Image.asset(
                "lib/images/research.png",
                fit: BoxFit.cover,
                alignment: FractionalOffset(0.5, 0.5),
              ),
            ),

            SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("RESEARCH",
                    style: TextStyle(color: Colors.black.withOpacity(1.0))),
              ],
            ),

            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Colors.blueGrey[100],
                  width: 170,
                  height: 170,
                  child: Image.asset(
                    "lib/images/forum.png",
                    fit: BoxFit.cover,
                    alignment: FractionalOffset(0.5, 0.5),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  color: Colors.blueGrey[100],
                  width: 170,
                  height: 170,
                  child: Image.asset(
                    "lib/images/chatbox.png",
                    fit: BoxFit.cover,
                    alignment: FractionalOffset(0.5, 0.5),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("FORUM ",
                    style: TextStyle(color: Colors.black.withOpacity(1.0))),
                SizedBox(width: 165),
                Text("CHATBOX",
                    style: TextStyle(color: Colors.black.withOpacity(1.0))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
