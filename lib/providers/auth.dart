import 'dart:convert';
import 'dart:wasm';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import './http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  String _userType;
  dynamic _teams;
  String _username;
  String _name;
  String _token1;

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

  String get token1 {
    return _token1;
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

  Future<void> _register() async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    final token1 = await _firebaseMessaging.getToken();
    sendReg(token1);
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
        _register();
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
    await _register();
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
      print(_teams['data'][0]);

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> evaluate(
    double novelty,
    double techFeasibility,
    double techImplementation,
    double impact,
    double qualityRepr,
    double bussinessModel,
    double scalability,
    String review,
    String notes,
    String suggestions,
    String teamId,
    String evalId,
    int round,
  ) async {
    print(round);
    print('Eval CP');
    print(notes);
    final url = 'http://api-devsoc.herokuapp.com/evaluvate/';

    final res = await http.post(url, headers: {
      'Authorization': _token,
      'Content-Type': 'application/json'
    }, body: jsonEncode({
    'novelty_slider': novelty.toInt(),
    'tech_feasability_slider': techFeasibility.toInt(),
    'impact_slider': impact.toInt(),
    'presentation_quality_slider': qualityRepr.toInt(),
    'bussiness_model_slider': bussinessModel.toInt(),
    'scalability_slider': scalability.toInt(),
    'remarks': review,
    'notes': notes,
    'suggesstions_given': suggestions,
    'team_id': teamId,
    'evaluator': evalId,
  }));
    print(res.statusCode);
    print(res.body);
    try {} catch (e) {
      print(e);
    }
  }

  Future<void> sendReg(String deviceId) async {
    String url = 'http://api-devsoc.herokuapp.com/register/';
    try {
      final response = await http.post(
        url,
        headers: {'Authorization': _token},
        body: {'device_id': deviceId},
      );
      print(response.body);
      // final responseBody = json.decode(response.body);
      print(response.statusCode);

      if (response.statusCode == 204) {
        print('OK');
        notifyListeners();
      } else {
        throw HttpException(
            'Unable to change password with provided credentials.');
      }
    } on HttpException catch (e) {
      // throw e;
      print(e.toString());
    }
  }

  Future<void> changePass(
      String currentPass, String newPass, String newConfirmPass) async {
    print('checkpointttttt');
    String url = 'http://api-devsoc.herokuapp.com/auth/users/set_password/';
    try {
      final response = await http.post(url, headers: {
        'Authorization': _token
      }, body: {
        'current_password': currentPass,
        'new_password': newPass,
        're_new_password': newConfirmPass
      });
      print(response.body);
      // final responseBody = json.decode(response.body);
      print(response.statusCode);

      if (response.statusCode == 204) {
        print('OK');
        notifyListeners();
      } else {
        throw HttpException(
            'Unable to change password with provided credentials.');
      }
    } on HttpException catch (e) {
      throw e;
    }
  }

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

  Future<void> message(bool messageCon, String messageHead, String messageBody,
      String teamNumber) async {
    print('checkpointttttt');
    String url = 'https://api-devsoc.herokuapp.com/message/';
    String messageConf = 'False';
    if (messageCon == true) {
      messageConf = 'True';
    } else {
      messageConf = 'False';
    }
    try {
      final response = await http.post(url, headers: {
        'Authorization': _token
      }, body: {
        'message_conf': messageConf,
        'message_heading': messageHead,
        'message_body': messageBody,
        'team': teamNumber
      });
      print(response.body);
      // final responseBody = json.decode(response.body);
      print(response.statusCode);
      if (response.statusCode == 201) {
        print('OK');
        notifyListeners();
      } else {
        throw HttpException(
            'Unable to change password with provided credentials.');
      }
    } on HttpException catch (e) {
      throw e;
    }
  }
}
