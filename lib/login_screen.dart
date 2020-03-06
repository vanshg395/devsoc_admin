import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool visisblePassword = false;
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  String errorMessage = '';
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    final email = _authData['email'];
    final password = _authData['password'];
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).login(email, password);
    } catch (error) {
      errorMessage = error.toString();
      setState(() {
        _emailController.text = '';
        _passController.text = '';
      });
      showDialog(
        context: context,
        builder: (context) => Platform.isIOS
            ? CupertinoAlertDialog(
                title: Text('Authentication Error'),
                content: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(errorMessage),
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              )
            : AlertDialog(
                title: Text('Authentication Error'),
                content: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(errorMessage),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF030D18),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Color(0xCC14192D),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 30.0, left: 20),
                            child: Row(
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: <Widget>[
                                Text(
                                  'DEVSOC',
                                  style: TextStyle(
                                      fontSize: 22,
                                      textBaseline: TextBaseline.alphabetic,
                                      fontFamily: 'SFProTextSemibold'),
                                ),
                                Text(
                                  '20',
                                  style: TextStyle(
                                    fontSize: 32,
                                    textBaseline: TextBaseline.alphabetic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Container(
                              height: 100,
                              padding: EdgeInsets.only(top: 20),
                              child: Image.asset(
                                'assets/img/others/devsoc_shadow.png',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  labelStyle: TextStyle(color: Colors.white),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                keyboardAppearance: Brightness.light,
                                validator: (val) {
                                  if (val == '') {
                                    return 'This Field is required.';
                                  }
                                },
                                onSaved: (val) {
                                  _authData['email'] = val;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _passController,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      visisblePassword
                                          ? FontAwesomeIcons.eye
                                          : FontAwesomeIcons.eyeSlash,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        visisblePassword = !visisblePassword;
                                      });
                                    },
                                  ),
                                  labelText: 'Password',
                                  labelStyle: TextStyle(color: Colors.white),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                keyboardAppearance: Brightness.light,
                                obscureText: !visisblePassword,
                                validator: (val) {
                                  if (val == '') {
                                    return 'This Field is required.';
                                  }
                                },
                                onSaved: (val) {
                                  _authData['password'] = val;
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 40,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: _isLoading
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                              Colors.blue,
                                            ),
                                          ),
                                        )
                                      : RaisedButton(
                                          color: Color(0xff3284ff),
                                          textColor: Colors.white,
                                          child: Text(
                                            'SIGN IN',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'SFProTextSemiMed',
                                            ),
                                          ),
                                          onPressed: _submit,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
