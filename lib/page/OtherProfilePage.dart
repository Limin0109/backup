import 'package:biofuture/page/chat_room.dart';
import 'package:biofuture/widgets/appbar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OthersProfile extends StatefulWidget {
  String author;

  OthersProfile({
    required this.author,
  });

  @override
  OthersProfileState createState() => OthersProfileState(author: this.author);
}

class OthersProfileState extends State<OthersProfile> {
  String author;
  QuerySnapshot? userSnapShot;
  profile _profile = new profile();

  OthersProfileState({required this.author});

  @override
  void initState() {
    _profile.getUser(author).then((result) {
      setState(() {
        userSnapShot = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent[900],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.chat_bubble),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ChatRoom()));
              },
            )
          ],
        ),
        body: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .where("name", arrayContains: author)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return UserProfile();
            },
          ),
        ));
  }

  Widget UserProfile() {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Profile(
            name: userSnapShot!.docs[index].get("name"),
            urlAvatar: userSnapShot!.docs[index].get("urlAvatar"),
            email: userSnapShot!.docs[index].get("email"),
            about: userSnapShot!.docs[index].get("about"),
          );
        },
      ),
    );
  }
}

class Profile extends StatelessWidget {
  final String name, urlAvatar, email, about;

  Profile(
      {required this.about,
      required this.email,
      required this.name,
      required this.urlAvatar});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 12),
        ProfilePic(),
        const SizedBox(height: 24),
        buildName(),
        const SizedBox(height: 48),
        buildAbout(),
      ],
    );
  }

  Widget ProfilePic() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: NetworkImage(urlAvatar), //assign the url
          fit: BoxFit.cover,
          width: 128,
          height: 128,
        ),
      ),
    );
  }

  Widget buildName() => Column(
        children: [
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: TextStyle(color: Colors.grey),
          )
        ],
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
              about,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}

class profile {
  String? author;
  getUser(author) async {
    return await FirebaseFirestore.instance.collection("user").get();
  }
}
