import 'dart:io';

import 'package:biofuture/model/ResearchApi.dart';
import 'package:biofuture/model/apiPDF.dart';
import 'package:biofuture/page/OtherProfilePage.dart';
//import 'package:biofuture/page/CommentSection.dart';
import 'package:biofuture/page/RealCommentPage.dart';
import 'package:biofuture/page/ViewPDF.dart';
import 'package:biofuture/widgets/appbar_research.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class ViewPost extends StatefulWidget {
  @override
  _ViewPost createState() => _ViewPost();
}

class _ViewPost extends State<ViewPost> {
  CrudMethods crudMethods = new CrudMethods();
  QuerySnapshot? posSnapShot;
  //Stream ? posStream;

  @override
  void initState() {
    crudMethods.getData().then((result) {
      setState(() {
        posSnapShot = result;
      });
    });
    super.initState();
  }

  /* @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection("research_post").get().then((value) {})
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarResearch(context),
        body: Container(
            padding: EdgeInsets.all(2),
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("research_post")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return posList();
                }))
        /* posSnapShot != null
            ? posList()
            : Container(
                child: Center(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),*/
        );
  }

  Widget TopBanner() {
    final top =
        'https://images.unsplash.com/photo-1507842217343-583bb7270b66?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bGlicmFyeSUyMGludGVyaW9yfGVufDB8fDB8fA%3D%3D&w=1000&q=80';
    return Container(
      padding: EdgeInsets.all(25),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          image: NetworkImage(top),
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
            'Research Paper',
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget posList() {
    return Container(
      child: ListView.builder(
          padding: EdgeInsets.only(top: 24),
          itemCount: posSnapShot!.docs.length,
          itemBuilder: (context, index) {
            //QueryDocumentSnapshot x = posSnapShot!.docs[index];
            return PosTitle(
              author: posSnapShot!.docs[index].get("author"),
              title: posSnapShot!.docs[index].get("title"),
              desc: posSnapShot!.docs[index].get("desc"),
              github: posSnapShot!.docs[index].get("github"),
              ncbi: posSnapShot!.docs[index].get("ncbi"),
              imgURL: posSnapShot!.docs[index].get("imgURL"),
              urlAvatar: posSnapShot!.docs[index].get("urlAvatar"),
              postID: posSnapShot!.docs[index].get("postID"),
              pdffrontpage: posSnapShot!.docs[index].get("pdffrontpage"),
            );
          }),
    );
  }
}

class PosTitle extends StatelessWidget {
  bool _hasBeenPressed = false;
  final String imgURL,
      title,
      desc,
      author,
      github,
      ncbi,
      urlAvatar,
      postID,
      pdffrontpage;
  PosTitle(
      {required this.author,
      required this.desc,
      required this.github,
      required this.imgURL,
      required this.ncbi,
      required this.title,
      required this.urlAvatar,
      required this.postID,
      required this.pdffrontpage});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 24, right: 16, left: 16),
        child: Container(
          width: double.infinity,
          height: 760,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Column(children: <Widget>[
                  ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        child: ClipOval(
                          child: Image.network(
                            urlAvatar, //wait avatarURL
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    title: TextButton(
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => OthersProfile(
                                    author: author,
                                  )));
                        },
                        child: Text(
                          author,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),

                    /*Text(
                      author,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),*/
                    trailing: IconButton(
                      icon: Icon(Icons.more_horiz),
                      color: Colors.black,
                      onPressed: () => print('More'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    desc,
                    maxLines: 3,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                  InkWell(
                    onDoubleTap: () => print('Like Post'),
                    onTap: () async {
                      final url = imgURL;
                      final file = await PDFApi.loadNetwork(url);
                      print(url);
                      if (file == null) return print('nothing dey');
                      openPDF(context, file, title);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      height: 400.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 5),
                            blurRadius: 8,
                          ),
                        ],
                        image: DecorationImage(
                          image: NetworkImage(pdffrontpage),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: [
                            SizedBox(
                              width: 400,
                              child: Text(
                                ncbi,
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            SizedBox(
                                width: 400,
                                child: Text(
                                  github,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                  ),
                                ))
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                IconButton(
                                    icon: new Icon(
                                      Icons.favorite_rounded,
                                    ),
                                    color: _hasBeenPressed
                                        ? Colors.teal
                                        : Colors.deepOrange[400],
                                    onPressed: () => {
                                          _hasBeenPressed != _hasBeenPressed,
                                          print("Like post"),
                                        }),
                              ],
                            ),
                            const SizedBox(width: 5),
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.chat),
                                  iconSize: 30.0,
                                  onPressed: () => showComments(
                                    //final url = imgURL;
                                    context,
                                    postID: postID,
                                    author: author,
                                    desc: desc,
                                    github: github,
                                    ncbi: ncbi,
                                    title: title,
                                    imgURL: imgURL,
                                    urlAvatar: urlAvatar,
                                    pdffrontpage: pdffrontpage,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              )
            ],
          ),
        ));
  }
}

void openPDF(BuildContext context, File file, String title) =>
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => PDFViewerPage(
                file: file,
                title: title,
              )),
    );

showComments(BuildContext context,
    {required String postID,
    required String author,
    required String pdffrontpage,
    required String title,
    required String desc,
    required String github,
    required String ncbi,
    required String imgURL,
    required String urlAvatar}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return PostComments(
      postID: postID,
      author: author,
      pdffrontpage: pdffrontpage,
      title: title,
      desc: desc,
      github: github,
      ncbi: ncbi,
      imgURL: imgURL,
      urlAvatar: urlAvatar,
    );
  }));
}
