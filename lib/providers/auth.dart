import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import './http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  String _userType;
  dynamic _teams;
  String _username;
  String _name;

  int get userType {
    if ((_userType == 'Core-2nd Year') || (_userType == 'Board')) {
      return 2;
    } else if ((_userType == 'Core-1st Year')) {
      return 3;
    } else {
      return 1;
    }
  }

  String get userTypeText {
    return _userType;
  }

  String get token {
    return _token;
  }

  bool get isAuth {
    return token != null;
  }

  dynamic get teamInfo {
    return _teams;
  }

  String get username {
    return _username;
  }

  String get name {
    return _name;
  }

  Future<void> login(String email, String password) async {
    String url = 'https://api-devsoc.herokuapp.com/token/login';
    try {
      final response = await http.post(url, body: {
        'username': email,
        'password': password,
      });
      final responseBody = json.decode(response.body);
      print(responseBody);
      if (response.statusCode == 200) {
        _userType = responseBody['user_type'];
        _token = 'Token ' + responseBody['token']['auth_token'];
        _username = responseBody['username'];
        _name = responseBody['name'];
        final prefs = await SharedPreferences.getInstance();
        final data = json.encode({
          'token': _token,
          'userType': _userType,
          'username': _username,
          'name': _name,
        });
        prefs.setString('userData', data);
        getTeams();
        notifyListeners();
      } else {
        throw HttpException('Unable to log in with provided credentials.');
      }
    } on HttpException catch (e) {
      throw e;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    print(extractedUserData);
    _token = extractedUserData['token'];
    _userType = extractedUserData['userType'];
    _username = extractedUserData['username'];
    _name = extractedUserData['name'];
    getTeams();
    notifyListeners();
    return true;
  }

  Future<void> getTeams() async {
    String url = 'https://api-devsoc.herokuapp.com/list/';
    try {
      final response = await http.get(url, headers: {'Authorization': _token});
      print(response.body);
      final responseBody = json.decode(response.body);
      _teams = responseBody;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> evaluate() async {}

  Future<void> logout() async {
    print(1);
    String url = 'http://api-devsoc.herokuapp.com/auth//token/logout/';
    final response = await http.get(url, headers: {'Authorization': _token});
    print(response.statusCode);
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    _token = null;
    _userType = null;
    _username = null;
    _name = null;
    notifyListeners();
  }
}
