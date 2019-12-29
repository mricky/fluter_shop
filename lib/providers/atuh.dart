import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
class Auth with ChangeNotifier{
  String _token;
  DateTime _expireDate;
  String _userId;

  Future<void> _authenticate(String email, String password, String uriSegment) async {
     final url = 'https://identitytoolkit.googleapis.com/v1/accounts:$uriSegment?key=AIzaSyDSgCaCAM4jD4KsR9Qh19bl9qud5NR6Mus';
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
  Future<void> signup(String email, String password) async{
    return _authenticate(email, password, 'signUp');
   
  }
  Future<void> login(String email, String password) async{
   return _authenticate(email, password, 'signInWithPassword');
  }
}