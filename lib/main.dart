import 'package:double_fresh/model/Post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  List<Post> _posts = [];

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

  // 처음 한 번만 호출
  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: this._posts.length,
          itemBuilder: (context, index) {
            final post = this._posts[index];
            return ListTile (
              title: Text(post.title),
              subtitle: Text('Id: ${post.id}  UserId: ${post.userId}')
            );
          },
        ),
      ),
    );
  }
}
