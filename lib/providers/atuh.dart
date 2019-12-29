import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
class Auth with ChangeNotifier{
  String _token;
  DateTime _expireDate;
  String _userId;

  Future<void> signup(String email, String password) async{
    const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDSgCaCAM4jD4KsR9Qh19bl9qud5NR6Mus';
    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true
        },
        ),
      );
      print(json.decode(response.body));
  }
}