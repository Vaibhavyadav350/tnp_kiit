import 'package:flutter/material.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';

class PDFViewPage extends StatefulWidget {
  final String url;

  PDFViewPage({required this.url});

  @override
  _PDFViewPageState createState() => _PDFViewPageState();
}

class _PDFViewPageState extends State<PDFViewPage> {
  bool _isLoading = true;
  late PDFDocument document;

  @override
  void initState() {
    super.initState();
    print("Passed URL: ${widget.url}");
    loadDocument();
  }

  loadDocument() async {
    print("  print the url $widget.url");
    try {
      document = await PDFDocument.fromURL(widget.url);
      setState(() => _isLoading = false);
    } catch (e) {
      print("Error loading document: $e");
      setState(() => _isLoading = false);
    }
  }

  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : PDFViewer(document: document),
      ),
    );
  }
}
