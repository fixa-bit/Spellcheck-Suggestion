import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

/// Represents Homepage for Navigation
class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  Uint8List? _documentBytes;
  @override
  void initState() {
    getPdfBytes();
    super.initState();
  }

  ///Get the PDF document as bytes
  void getPdfBytes() async {
    _documentBytes = await http.readBytes(Uri.parse(
        'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Syncfusion Flutter PDF Viewer'),
      ),
      body: _documentBytes != null
          ? SfPdfViewer.memory(
              _documentBytes!,
            )
          : Container(color: const Color.fromARGB(255, 32, 7, 6),),
    );
  }
}