import 'package:biofuture/widgets/forumpage.dart';
import 'package:flutter/material.dart';
import 'package:biofuture/widgets/forumpage.dart';
import 'package:biofuture/widgets/menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Forumpage(),
      appBar: AppBar(
        title: Text('halloo'),
      ),
      body: Center(
        child: Text(' Tutorial'),
      ),
    );
  }
}
