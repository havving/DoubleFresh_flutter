import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'http 서버 데이터 전송'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _text = '변경되기 전!';
  var _url = Uri.parse('http://192.168.0.22:3000/');
  var _url2 = Uri.parse('http://192.168.0.22:3000/data');

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
            Text('버튼을 누르면 하단 글귀가 변경됩니다.', style: TextStyle(color: Colors.indigo, fontSize: 20.0, fontWeight: FontWeight.bold),),
            Text( '$_text', style: TextStyle(color: Colors.green, fontSize: 36.0, fontWeight: FontWeight.bold) ),
          ],
        ),
      ),

      floatingActionButton: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                onPressed: () async {
                  http.Response _res = await http.get(_url);
                  print(_res.statusCode);
                  print(_res.body);
                  setState(() {
                    _text = _res.body;
                  });
                },
                child: Icon(Icons.chevron_left),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: const EdgeInsets.only(left: 180.0),
                  child: Text("Get  Post", style: TextStyle(color: Colors.blueAccent, fontSize: 28.0, fontWeight: FontWeight.bold),)
              ),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child:  FloatingActionButton(
                onPressed: () async {
                  var data = {
                    "id" : "ID0205",
                    "name" : "이병준",
                    "age" : "25"
                  };
                  var body = json.encode(data);
                  http.Response _res = await http.post(_url2, headers: {"Content-Type": "application/json"}, body: body);
                  print(_res.statusCode);
                  print(_res.body);
                  setState(() {
                    _text = _res.body;
                  });
                },
                child: Icon(Icons.chevron_right),
              ),
            )
          ]
      ),
    );
  }
}










/*
import 'package:double_fresh/model/Post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HttpExampleWidget(),
    );
  }
  }

class HttpExampleWidget extends StatefulWidget {
  @override
  _HttpExampleWidgetState createState() => _HttpExampleWidgetState();
}

class _HttpExampleWidgetState extends State<HttpExampleWidget> {
  late Future<Post> post;

  Future<Post> fetchPost() async {
    var url = Uri.parse('http://localhost:3000/signup');
    final response = await http.post(
      url,
      body: jsonEncode(
        {
          'id': "12",
          'password': "1234",
          'name': "Jin",
          'phone': "0101234123"
        },
      ),
      headers: {'Content-Type': "application/json"},
    );

    if (response.statusCode == 200 ) {
      return Post.fromJSON(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }


  List<Post> _posts = [];

  // GET
  void _fetchPosts() async {
    // 실제 http 호출 (비동기)
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.get(url);
    final List<Post> parseResponse = jsonDecode(response.body)
        .map<Post>((json) => Post.fromJSON(json))
        .toList();
    setState(() {
      _posts.clear();
      _posts.addAll(parseResponse);
    });
  }

  // POST
  void _createPost() async {
    // var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var url = Uri.parse('http://192.168.0.22:3000/signup');
    final response = await http.post(
      url,
      body: jsonEncode(
        {
          'id': "12",
          'password': "1234",
          'name': "Jin",
          'phone': "0101234123"
        },
      ),
      headers: {'Content-Type': "application/json"},
    );


    final Post parsedResponse = Post.fromJSON(jsonDecode(response.body));
    _posts.clear();
    _posts.add(parsedResponse);
  }

  // 처음 한 번만 호출
  @override
  void initState() {
    super.initState();
    post = fetchPost();
    // _fetchPosts();
    // _createPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: this._posts.length,
          itemBuilder: (context, index) {
            final post = this._posts[index];
            return ListTile(
                title: Text(post.name),
                subtitle: Text('Id: ${post.id}  Phone: ${post.phone}'));
          },
        ),
      ),
    );
  }
}
*/
