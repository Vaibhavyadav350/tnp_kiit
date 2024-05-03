import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutTNP extends StatelessWidget {
  const AboutTNP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SafeArea(
          child: WebView(
          initialUrl: 'https://kiit.ac.in/training-placement/',
          javascriptMode: JavascriptMode.unrestricted,
                ),
        ),
      ),
    );
  }
}
