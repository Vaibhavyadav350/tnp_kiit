import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutTNP extends StatelessWidget {
  const AboutTNP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("TNP KIIT"),
        ),
        body: WebView(
        initialUrl: 'https://kiit.ac.in/training-placement/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
      ),
    );
  }
}
