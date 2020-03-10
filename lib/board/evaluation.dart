import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class EvavluationPage extends StatefulWidget {
  @override
  _EvavluationPageState createState() => _EvavluationPageState();

  final String teamName;
  final String teamId;
  final String evalId;
  final int round;
  EvavluationPage(this.teamName, this.teamId, this.evalId, this.round);
}

class _EvavluationPageState extends State<EvavluationPage> {
  double _novelty = 5;
  double _techFeasibility = 5;
  double _techImplementation = 5;
  double _impact = 5;
  double _qualityRepr = 5;
  double _bussinessModel = 5;
  double _scalability = 5;
  bool _isLoading = false;
  TextEditingController _reviewController = TextEditingController();
  TextEditingController _notesController = TextEditingController();
  TextEditingController _suggestionsController = TextEditingController();

  Map<String, String> _evalData = {
    'reviews': '',
    'notes': '',
    'suggestions': '',
  };
  final GlobalKey<FormState> _formKey = GlobalKey();
  String errorMessage = '';

  Future<void> _submit() async {
    print('Checkpoint 1');
    final _review = _evalData['reviews'];
    final _notes = _evalData['notes'];
    final _suggestions = _evalData['suggestions'];
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).evaluate(
        _novelty,
        _techFeasibility,
        _techImplementation,
        _impact,
        _qualityRepr,
        _bussinessModel,
        _scalability,
        _review,
        _notes,
        _suggestions,
        widget.teamId,
        widget.evalId,
        widget.round,
      );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => BoardScreen(),
      //   ),
      // );
      Navigator.of(context).pop();
    } catch (error) {
      errorMessage = error.toString();
      print(errorMessage);
      setState(() {
        _notesController.text = '';
        _reviewController.text = '';
        _suggestionsController.text = '';
      });
      showDialog(
        context: context,
        builder: (context) => Platform.isIOS
            ? CupertinoAlertDialog(
                title: Text('Error in posting details'),
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
                title: Text('Error in posting details'),
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF030D18),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Hero(
                    tag: 'evalHead',
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Text(
                        'EVALUATE',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      'Team Name: ${widget.teamName}',
                      style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: 17,
                          ),
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Slider.adaptive(
                    value: _novelty.toDouble(),
                    onChanged: (double newValue) {
                      setState(() {
                        _novelty = newValue;
                      });
                    },
                    activeColor: Colors.blue,
                    min: 0,
                    max: 10,
                    divisions: 20,
                    label: _novelty.toString(),
                  ),

                  Container(
                    alignment: Alignment(1.0, 0.0),
                    padding: EdgeInsets.only(top: 10.0, left: 20.0),
                    child: Text(
                      'Novelty of the Idea' +
                          (Platform.isIOS ? ': ' + _novelty.toString() : ''),
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),

                  // idea feasbility
                  Slider.adaptive(
                    value: _techFeasibility.toDouble(),
                    onChanged: (double newValue) {
                      setState(() {
                        _techFeasibility = newValue;
                      });
                    },
                    activeColor: Colors.blue,
                    min: 0,
                    max: 10,
                    divisions: 20,
                    label: _techFeasibility.toString(),
                  ),
                  Container(
                    alignment: Alignment(1.0, 0.0),
                    padding: EdgeInsets.only(top: 10.0, left: 20.0),
                    child: Text(
                      'Technical Fesability' +
                          (Platform.isIOS
                              ? ': ' + _techFeasibility.toString()
                              : ''),
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  if (widget.round == 3)
                    Slider.adaptive(
                      value: _techImplementation.toDouble(),
                      onChanged: (double newValue) {
                        setState(() {
                          _techImplementation = newValue;
                        });
                      },
                      activeColor: Colors.blue,
                      min: 0,
                      max: 10,
                      divisions: 20,
                      label: _techImplementation.toString(),
                    ),
                  if (widget.round == 3)
                    Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(top: 10.0, left: 20.0),
                      child: Text(
                        'Implementation Till Now' +
                            (Platform.isIOS
                                ? ': ' + _techImplementation.toString()
                                : ''),
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                  if (widget.round == 3)
                    SizedBox(
                      height: 40,
                    ),

                  // impleementation till now

                  // Marketic Strategy
                  Slider.adaptive(
                    value: _impact.toDouble(),
                    onChanged: (double newValue) {
                      setState(() {
                        _impact = newValue;
                      });
                    },
                    activeColor: Colors.blue,
                    min: 0,
                    max: 10,
                    divisions: 20,
                    label: _impact.toString(),
                  ),
                  Container(
                    alignment: Alignment(1.0, 0.0),
                    padding: EdgeInsets.only(top: 10.0, left: 20.0),
                    child: Text(
                      'Impact of the Project' +
                          (Platform.isIOS ? ': ' + _impact.toString() : ''),
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  // quality of representation
                  Slider.adaptive(
                    value: _qualityRepr.toDouble(),
                    onChanged: (double newValue) {
                      setState(() {
                        _qualityRepr = newValue;
                      });
                    },
                    activeColor: Colors.blue,
                    min: 0,
                    max: 10,
                    divisions: 20,
                    label: _qualityRepr.toString(),
                  ),
                  Container(
                    alignment: Alignment(1.0, 0.0),
                    padding: EdgeInsets.only(top: 10.0, left: 20.0),
                    child: Text(
                      'Quality of Representation' +
                          (Platform.isIOS
                              ? ': ' + _qualityRepr.toString()
                              : ''),
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  // bussiness mdoel
                  Slider.adaptive(
                    value: _bussinessModel.toDouble(),
                    onChanged: (double newValue) {
                      setState(() {
                        _bussinessModel = newValue;
                      });
                    },
                    activeColor: Colors.blue,
                    min: 0,
                    max: 10,
                    divisions: 20,
                    label: _bussinessModel.toString(),
                  ),

                  Container(
                    alignment: Alignment(1.0, 0.0),
                    padding: EdgeInsets.only(top: 10.0, left: 20.0),
                    child: Text(
                      'Bussiness Model' +
                          (Platform.isIOS
                              ? ': ' + _bussinessModel.toString()
                              : ''),
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  // scalability & accuracy
                  Slider.adaptive(
                    value: _scalability.toDouble(),
                    onChanged: (double newValue) {
                      setState(() {
                        _scalability = newValue;
                      });
                    },
                    activeColor: Colors.blue,
                    min: 0,
                    max: 10,
                    divisions: 20,
                    label: _scalability.toString(),
                  ),

                  Container(
                    alignment: Alignment(1.0, 0.0),
                    padding: EdgeInsets.only(top: 10.0, left: 20.0),
                    child: Text(
                      'Scalability & Accuracy of the Project' +
                          (Platform.isIOS
                              ? ': ' + _scalability.toString()
                              : ''),
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),

                  //Remarks
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 3,
                    controller: _reviewController,
                    decoration: InputDecoration(
                      labelText: 'Reviews',
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
                    onChanged: (value) => _evalData['remarks'] = value,
                  ),

                  //notes given
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 3,
                    controller: _notesController,
                    decoration: InputDecoration(
                      labelText: 'Notes',
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
                    onChanged: (value) => _evalData['suggestions'] = value,
                  ),

                  //suggestions given
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 3,
                    controller: _suggestionsController,
                    decoration: InputDecoration(
                      labelText: 'Suggestions',
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
                    onChanged: (value) => _evalData['suggestions'] = value,
                  ),

                  SizedBox(
                    height: 40,
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
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
