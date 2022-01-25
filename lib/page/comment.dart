import 'package:flutter/material.dart';

class Comment extends StatefulWidget {
  const Comment({Key? key}) : super(key: key);

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  List<String> _comments = [
    "very insightfull!!",
    "now I understand",
  ];

  void _addComment(String val) {
    setState(() {
      _comments.add(val);
    });
  }

  Widget _buildCommentList() {
    return ListView.builder(itemBuilder: (context, index) {
      if (index < _comments.length) {
        return _buildCommentItem(_comments[index]);
      }
      return _buildCommentItem(" ");
    });
  }

  Widget _buildCommentItem(String comment) {
    return ListTile(title: Text(comment));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: Text("Comments")),
        body: Column(
          children: <Widget>[
            Expanded(child: _buildCommentList()),
            TextField(
              onSubmitted: (String submittedStr) {
                _addComment(submittedStr);
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20.0),
                  hintText: "Add comment"),
            )
          ],
        ));
  }
}
