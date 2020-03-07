import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import 'dart:io';
import 'tabsScreen.dart';
class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {

  TextEditingController _messageHeadController = TextEditingController();
  TextEditingController _messageBodyController = TextEditingController();
  TextEditingController _teamNumberController = TextEditingController();
  

  bool visisblePassword = false;
  bool _isLoading = false;
  bool isSwitched = false;
  Map<String, String> _authData = {
    'messageHead': '',
    'messageBody': '',
  };
  String teamNumber1;
  final GlobalKey<FormState> _formKey = GlobalKey();

  String errorMessage = '';

  Future<void> _submit() async {
    print('Checkpoint 1');
    final messageHead = _authData['messageHead'];
    final messageBody = _authData['messageBody'];
    final teamNumber = teamNumber1;
    print(messageBody);
    setState(() {
      _isLoading = true;
    });
    try {
      print(_authData);
      await Provider.of<Auth>(context, listen: false).message(isSwitched,messageHead,messageBody,teamNumber);
      Navigator.push(context,MaterialPageRoute(builder: (context)=> BoardScreen(),),);
    } catch (error) {
      errorMessage = error.toString();
      print(errorMessage);
      setState(() {
        _messageHeadController.text = '';
        _messageBodyController.text = '';

      });
      showDialog(
        context: context,
        builder: (context) => Platform.isIOS
            ? CupertinoAlertDialog(
                title: Text('Error in sending message'),
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
                backgroundColor: Colors.grey,
                title: Text('Error in sending message'),
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
      backgroundColor: Color(0xFF030D18),

      body:Container(
        padding: EdgeInsets.symmetric(horizontal: 20),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  'MESSAGE',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              SizedBox(
                height: 30,
              ),

              SwitchListTile(
              title: const Text('For Evaluation?'),
              value: isSwitched,
              onChanged: (bool value) {
                setState(() {
                  isSwitched = value;
                });
              },
              secondary: const Icon(Icons.security,color: Colors.grey,),
              ),
              SizedBox(
                height: 20,
              ),
              

              TextFormField(
              controller: _messageHeadController,
              decoration: InputDecoration(

                labelText: 'Message Head',
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
              keyboardType: TextInputType.text,
              keyboardAppearance: Brightness.light,
              
              onChanged: (value) => _authData['messageHead'] = value,
              
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 2,
                controller: _messageBodyController,
                decoration: InputDecoration(
                
                labelText: 'Message Body',
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
              keyboardAppearance: Brightness.light,
              
              
              onChanged: (value) => _authData['messageBody'] = value,
              
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _teamNumberController,
                decoration: InputDecoration(
                
                labelText: 'Team Number',
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
              keyboardAppearance: Brightness.light,
              
              
              onChanged: (value) => teamNumber1 = value,
              
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
                            'Submit',
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
    );
  }
}