import 'package:flutter/material.dart';

AppBar appbarHis(BuildContext context) {
  return AppBar(
    /* leading: GestureDetector(
      child: Icon(
        Icons.menu,
      ),
      onTap: () {},
    ),*/
    title: Text('User History'),
    backgroundColor: Colors.lightBlue[300],
    elevation: 0,
  );
}
