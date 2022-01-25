import 'package:biofuture/test/TestForumPost.dart';
import 'package:flutter/material.dart';
import 'package:biofuture/widgets/newpost.dart';
import 'package:biofuture/widgets/post_1.dart';

class Forumpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.lightBlue[100],
        elevation: 0,
        title: Text('Forum'),
      ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [NewPost(), const SizedBox(height: 2), ForumPost()],
          ),
        ),
      ),
    );
  }
}
