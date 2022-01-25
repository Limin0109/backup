import 'package:biofuture/page/Upload_paper.dart';
//import 'package:biofuture/page/ViewPaper.dart';
import 'package:biofuture/page/view_post.dart';
import 'package:biofuture/widgets/appbar_research.dart';
import 'package:biofuture/widgets/menu.dart';
//import 'package:biofuture/widgets/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ResearchMenu extends StatefulWidget {
  @override
  _ResearchMenuState createState() => _ResearchMenuState();
}

class _ResearchMenuState extends State<ResearchMenu> {
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: appbarResearch(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(2),
        child: Column(
          children: [
            BuildTopDeco(),
            SizedBox(height: 100),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Color(0x8ACB88),
                  minimumSize: Size(300, 100)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => UploadPaper(),
                  ),
                );
              },
              child: Text(
                'Upload Research Paper',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Color(0x8ACB88),
                  minimumSize: Size(300, 100)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => ViewPost(),
                  ),
                );
              },
              child: Text(
                'Research Paper',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget BuildTopDeco() {
  final re =
      'https://www.columbia.edu/content/sites/default/files/styles/cu_crop/public/content/Research/machine-learning.jpeg?itok=vQ1uIfP9';
  return Container(
    padding: EdgeInsets.all(25),
    width: double.infinity,
    height: 200,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      image: DecorationImage(
        image: NetworkImage(re),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.25),
          BlendMode.darken,
        ),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Research Centre",
          style: TextStyle(
              fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    ),
  );
}
