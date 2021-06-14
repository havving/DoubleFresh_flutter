import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


void main() {
  runApp(MaterialApp(home: MyHomePage(title: 'url_launcher',)));
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _launchButton(String buttonText, String url) {
    return RaisedButton(
      onPressed: () async {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Text(buttonText),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _launchButton('open site', 'https://flutter.dev'),
            _launchButton('Call', 'tel:010 1234 5678'),
            _launchButton('SMS', 'sms:010 1234 5678'),
            _launchButton('Email',
                'mailto:naver@daum.net?subject=News&body=New%20plugin'),
          ],
        ),
      ),
    );
  }
}
