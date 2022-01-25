//import 'package:biofuture/forum/comment.dart';
import 'package:biofuture/model/PostApi.dart';
import 'package:biofuture/page/comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:biofuture/forum/PostApi.dart';

var loginUser = FirebaseAuth.instance.currentUser;

class Posts extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Posts> {
  bool _hasBeenPressed = false;
  CrudMethodsForum crudMethods = new CrudMethodsForum();
  QuerySnapshot? posSnapShot;

  @override
  void initState() {
    crudMethods.getData().then((result) {
      setState(() {
        posSnapShot = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      margin: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    child: CircleAvatar(),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    child: Text("username",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ],
          ),
          ConstrainedBox(
            constraints: new BoxConstraints(
              minHeight: 80,
              minWidth: 150,
              maxHeight: 600,
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: Container(
                margin: EdgeInsets.only(left: 30, top: 30, right: 30),
                child: Text(
                  'We all know that bioinformatics and computational biology are here to stay and that their impact on scientific thought and direction will be increasing in the future. Since there is a lot of interdisciplinary research being undertaken by folks who participate in this forum, I am curious as to what big and interesting biological problems folks think will be best solved either directly by computational approaches or in an integrated computational and bench science environment. Of course, I know that the answer to this is "everything", but I am really curious about specific questions in your field of interest.',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Raleway',
                      color: Colors.black.withOpacity(1.0)),
                )),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 100),
                alignment: Alignment.center,
                height: 100,
                width: MediaQuery.of(context).size.width * 0.33,
                child: Container(
                  width: 50,
                  child: Row(children: [
                    Container(
                      alignment: Alignment.center,
                      width: 50,
                      child: IconButton(
                          icon: new Icon(
                            Icons.favorite_rounded,
                          ),
                          color: _hasBeenPressed
                              ? Colors.teal
                              : Colors.deepOrange[400],
                          onPressed: () => {
                                setState(() {
                                  _hasBeenPressed = !_hasBeenPressed;
                                }),
                                print("press"),
                              }),
                    ),
                  ]),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 100),
                alignment: Alignment.center,
                height: 100,
                width: MediaQuery.of(context).size.width * 0.33,
                child: Container(
                  width: 50,
                  child: Row(children: [
                    Container(
                      alignment: Alignment.center,
                      width: 50,
                      child: IconButton(
                        icon: new Icon(
                          Icons.add_comment,
                        ),
                        color: Colors.deepOrange[400],
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Comment()),
                          );
                        },
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
          Expanded(
              child: SizedBox(
            height: 600,
            child: ShowPosts(),
          )),
          Container(
              padding: EdgeInsets.all(2),
              child: StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance.collection("Post").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return posList();
                  })),
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
              /*
              author: posSnapShot!.docs[index].get("author"),
              title: posSnapShot!.docs[index].get("title"),
              desc: posSnapShot!.docs[index].get("desc"),
              github: posSnapShot!.docs[index].get("github"),
              ncbi: posSnapShot!.docs[index].get("ncbi"),
              imgURL: posSnapShot!.docs[index].get("imgURL"),
              urlAvatar: posSnapShot!.docs[index].get("urlAvatar"),
              postID: posSnapShot!.docs[index].get("postID"),
              pdffrontpage: posSnapShot!.docs[index].get("pdffrontpage"),
              */
              user: posSnapShot!.docs[index].get("user"),
              urlAvatar: posSnapShot!.docs[index].get("urlAvatar"),
              post: posSnapShot!.docs[index].get("post"),
            );
          }),
    );
  }
}

class ShowPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Post").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            primary: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, i) {
              QueryDocumentSnapshot x = snapshot.data!.docs[i];
              //Timestamp time = x['timestamp'];
              //DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch);
              return ListTile(
                /*onTap: (){
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatScreen()));
                },*/
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(x['urlAvatar']),
                ),
                title: Text(x['user']),
                //subtitle: Text(x['timestamp'].toDate().toString()),
                subtitle: Text(x['post']),
                //if want to show smth else, update firebase
                // subtitle: Text(x['smth_else']),

                // new users didn't add profile pic, so was assigned a empty url during registration @user_model.dart
              );
            });
      },
    );
  }
}

class PosTitle extends StatelessWidget {
  bool _hasBeenPressed = false;
  final String user, urlAvatar, post;
  PosTitle({
    required this.user,
    required this.urlAvatar,
    required this.post,
  });

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
                    title: Text(
                      user,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.more_horiz),
                      color: Colors.black,
                      onPressed: () => print('More'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    post,
                    maxLines: 3,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                  /*
                  InkWell(
                    onDoubleTap: () => print('Like Post'),
                    onTap: () async {
                      //final url = imgURL;
                      final file = await PDFApi.loadFirebase(imgURL);

                      if (file == null) return;
                      openPDF(context, file);
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
                  ),*/
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: [],
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
                                  onPressed: () =>
                                      print('wait comment section'),
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
