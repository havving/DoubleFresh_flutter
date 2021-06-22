import 'package:flutter/material.dart';

class WidgetDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo App',
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FirstPageState();
}

class FirstPageState extends State<FirstPage> {
  var result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('First Page'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: RaisedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SecondPage(
                          data: '(request)',
                        )),
                  ).then((value) {
                    setState(() {
                      result = value;
                    });
                  });
                },
                child: Text('Go to next page'),
              ),
            ),
            Text('$result'),
          ],
        ));
  }
}

class SecondPage extends StatelessWidget {
  final String data;

  SecondPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Second Page"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context, '(result)');
                },
                child: Text('Go to previous page'),
              ),
            ),
            Text('$data'),
          ],
        ));
  }
}