import 'dart:convert';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/http_exception.dart';

class Auth with ChangeNotifier{
  String _token;
  DateTime _expireDate;
  String _userId;

  var _authTimer;
  bool get isAuth{
    return token != null;
  }
  String get token {
    if(_expireDate != null &&
      _expireDate.isAfter(DateTime.now()) &&
      _token != null){
           return _token;
    }
    return null;
  }
  String get userId{
    return _userId;
  }
  Future<void> _authenticate(String email, String password, String uriSegment) async {
     final url = 'https://identitytoolkit.googleapis.com/v1/accounts:$uriSegment?key=AIzaSyDSgCaCAM4jD4KsR9Qh19bl9qud5NR6Mus';
       
      try {
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
      
      final responseData = json.decode(response.body);

      if(responseData['error'] != null){
          throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expireDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
            ),
          ),
      );
      // _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expireDate.toIso8601String()}
        );

      prefs.setString('userData', userData);
      }catch(error){
        throw error;
      }
      
  } 
  Future<void> signup(String email, String password) async{
    return _authenticate(email, password, 'signUp');
   
  }
  Future<void> login(String email, String password) async{
   return _authenticate(email, password, 'signInWithPassword');
  }
  Future<bool> tryAutoLogin() async{
    final prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey('userData')){
        return false;
    }
    final extractedUserData = json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    if(expiryDate.isBefore(DateTime.now())){
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expireDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;

  }
  Future<void> logout() async{
    _token = null;
    _userId = null;
    _expireDate = null;
    if(_authTimer != null){
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
     final prefs = await SharedPreferences.getInstance();
     //prefs.remove('userData');
    prefs.clear();

  }
  void _autoLogout(){
    if(_authTimer != null){
      _authTimer.cancel();
    }
    final timeToExpiry = _expireDate.difference(DateTime.now()).inSeconds;
    // try function 
     //_authTimer = Timer(Duration(seconds: 10), logout);
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);

  }
}