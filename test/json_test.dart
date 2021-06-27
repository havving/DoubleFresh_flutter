import 'dart:convert';

import 'package:double_fresh/model/user.dart';

void main() {
  var user = User(1111, "1111", "Jin", 13132424, '1');
  var toJson = user.toJson();
  print('${toJson['id']}');
  print('${toJson['password']}');
  print('${toJson['name']}');
  print('${toJson['phone']}');

  // jsonEncode() : 객체를 JSON 문자열로 변환
  String jsonString = jsonEncode(toJson);
  print(jsonString);

  // jsonDecode() : JSON 문자열을 String 으로 변환
  Map<String, dynamic> jsonMap = jsonDecode(jsonString);
  var fromJson = User.fromJson(jsonMap);
  print (fromJson.id);
  print (fromJson.password);
  print (fromJson.name);
  print (fromJson.phone);


}