import 'dart:convert';

import 'package:http/http.dart' as http;

class Networking {
  Future getData() async {
    http.Response response =
        await http.get(Uri.parse('https'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
    }
  }
}
