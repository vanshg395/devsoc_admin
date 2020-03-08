import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import 'package:flutter/services.dart';
import 'tabsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class EvavluationPage extends StatefulWidget {
  @override
  _EvavluationPageState createState() => _EvavluationPageState();
}

class _EvavluationPageState extends State<EvavluationPage> {
  double _techImplementation = 5;
  double _bussinessModel = 5;
  double _marketicStrategy = 5;
  double _ideaFeasability = 5;
  double _implementationTillNow = 5;
  bool _isLoading = false;
  TextEditingController _techImpController = TextEditingController();
  TextEditingController _ideaFesController = TextEditingController();
  TextEditingController _marketicStrController = TextEditingController();
  TextEditingController _bussinessModelController = TextEditingController();
  TextEditingController _remarksController = TextEditingController();
  TextEditingController _suggestionsController = TextEditingController();

  Map<String, String> _evalData = {
    'techImplementation': '',
    'ideaFesability': '',
    'marketicStrategy': '',
    'bussinessModel': '',
    'remarks': '',
    'suggestions': ''
  };
  final GlobalKey<FormState> _formKey = GlobalKey();
  String errorMessage = '';

  Future<void> _submit() async {
    print('Checkpoint 1');
    final techImplementation = _evalData['techImplementation'];
    final ideaFesability = _evalData['ideaFesability'];
    final marketicStrategy = _evalData['marketicStrategy'];
    final bussinessModel = _evalData['bussinessModel'];
    final remarks = _evalData['remarks'];
    final suggestions = _evalData['suggestions'];
    final _techImplementation1 = _techImplementation;
    final _bussinessModel1 = _bussinessModel;
    final _marketicStrategy1 = _marketicStrategy;
    final _ideaFeasability1 = _ideaFeasability;
    final _implementationTillNow1 = _implementationTillNow;
    setState(() {
      _isLoading = true;
    });
    try {
      print(_evalData);
      await Provider.of<Auth>(context, listen: false).evaluate(
          techImplementation,
          ideaFesability,
          marketicStrategy,
          bussinessModel,
          remarks,
          suggestions,
          _techImplementation1,
          _bussinessModel1,
          _marketicStrategy1,
          _ideaFeasability1,
          _implementationTillNow1);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BoardScreen(),
        ),
      );
    } catch (error) {
      errorMessage = error.toString();
      print(errorMessage);
      setState(() {
        _techImpController.text = '';
        _ideaFesController.text = '';
        _marketicStrController.text = '';
        _bussinessModelController.text = '';
        _remarksController.text = '';
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
    return Scaffold(
      backgroundColor: Color(0xFF030D18),
      body: SafeArea(
          child: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Text(
                    'Evaluation',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    'Team - ',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
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

                Container(
                  alignment: Alignment(1.0, 0.0),
                  padding: EdgeInsets.only(top: 10.0, left: 20.0),
                  child: Text(
                    'Tech Implementation Level ( 10 for best )',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 1,
                  controller: _techImpController,
                  decoration: InputDecoration(
                    labelText: 'Tech Implementation',
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
                  onChanged: (value) => _evalData['techImplementation'] = value,
                ),
                SizedBox(
                  height: 40,
                ),

                // idea feasbility
                Slider.adaptive(
                  value: _ideaFeasability.toDouble(),
                  onChanged: (double newValue) {
                    setState(() {
                      _ideaFeasability = newValue;
                    });
                  },
                  activeColor: Colors.blue,
                  min: 0,
                  max: 10,
                  divisions: 20,
                  label: _ideaFeasability.toString(),
                ),

                Container(
                  alignment: Alignment(1.0, 0.0),
                  padding: EdgeInsets.only(top: 10.0, left: 20.0),
                  child: Text(
                    'Idea Fesability Level ( 10 for best )',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 1,
                  controller: _ideaFesController,
                  decoration: InputDecoration(
                    labelText: 'Idea Fesability',
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
                  onChanged: (value) => _evalData['ideaFesability'] = value,
                ),
                SizedBox(
                  height: 40,
                ),

                // impleementation till now
                Slider.adaptive(
                  value: _implementationTillNow.toDouble(),
                  onChanged: (double newValue) {
                    setState(() {
                      _implementationTillNow = newValue;
                    });
                  },
                  activeColor: Colors.blue,
                  min: 0,
                  max: 10,
                  divisions: 20,
                  label: _implementationTillNow.toString(),
                ),
                Container(
                  alignment: Alignment(1.0, 0.0),
                  padding: EdgeInsets.only(top: 10.0, left: 20.0),
                  child: Text(
                    'Implementation Till Now ( 10 for best )',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                // Marketic Strategy
                Slider.adaptive(
                  value: _marketicStrategy.toDouble(),
                  onChanged: (double newValue) {
                    setState(() {
                      _marketicStrategy = newValue;
                    });
                  },
                  activeColor: Colors.blue,
                  min: 0,
                  max: 10,
                  divisions: 20,
                  label: _marketicStrategy.toString(),
                ),

                Container(
                  alignment: Alignment(1.0, 0.0),
                  padding: EdgeInsets.only(top: 10.0, left: 20.0),
                  child: Text(
                    'Marketic Strategy Level ( 10 for best )',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 1,
                  controller: _marketicStrController,
                  decoration: InputDecoration(
                    labelText: 'Marketic Strategy ',
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
                  onChanged: (value) => _evalData['marketicStrategy'] = value,
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
                    'Bussiness Model Level ( 10 for best )',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 1,
                  controller: _bussinessModelController,
                  decoration: InputDecoration(
                    labelText: 'Bussiness Model',
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
                  onChanged: (value) => _evalData['bussinessModel'] = value,
                ),

                //Remarks
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 2,
                  controller: _remarksController,
                  decoration: InputDecoration(
                    labelText: 'Remarks ',
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

                //suggestions given
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 2,
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
      )),
    );
  }
}
