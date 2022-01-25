import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';

class PDFViewerPage extends StatefulWidget {
  final File file;
  final String title;

  const PDFViewerPage({
    Key? key,
    required this.file,
    required this.title,
  }) : super(key: key);

  @override
  _PDFViewerPageState createState() =>
      _PDFViewerPageState(file: this.file, title: this.title);
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  final File file;
  final String title;

  _PDFViewerPageState({required this.file, required this.title});

  @override
  Widget build(BuildContext context) {
    //final name = basename(widget.file.path);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.lightBlue[100],
      ),
      body: PDFView(
        filePath: widget.file.path,
        autoSpacing: false,
      ),
    );
  }
}
