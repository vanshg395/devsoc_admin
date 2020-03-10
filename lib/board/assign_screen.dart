import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:http/http.dart' as http;

import '../providers/auth.dart';

class AssignScreen extends StatefulWidget {
  @override
  _AssignScreenState createState() => _AssignScreenState();
}

class _AssignScreenState extends State<AssignScreen> {
  // @override
  // void initState() {
  //   Future.delayed(Duration.zero, () async {
  //     await Provider.of<Auth>(context, listen: false).getAllTeams();
  //   });
  //   super.initState();
  // }

  @override
  void initState() {
    super.initState();
    _getEvaluators();
  }

  List<int> assignedEvaluators = [];
  Map<String, dynamic> evaluators;
  bool _isLoaded = false;

  Future<void> _submit() async {}

  List<bool> isSelected = [];

  Future<void> _getEvaluators() async {
    String url = 'http://api-devsoc.herokuapp.com/members';
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': Provider.of<Auth>(context, listen: false).token
        },
      );
      final resBody = json.decode(response.body);
      setState(() {
        evaluators = resBody;
        for (var i = 0; i < evaluators['usersCount']; i++) {
          isSelected.add(false);
        }
      });
      setState(() {
        _isLoaded = true;
      });
      print(response.body);
      print(isSelected);
    } catch (e) {
      print(e);
    }
  }

  void toggleSelection(int id, int i) {
    setState(() {
      if (isSelected[i]) {
        assignedEvaluators.remove(evaluators['data'][i]['user_id']);
        isSelected[i] = false;
      } else {
        assignedEvaluators.add(evaluators['data'][i]['user_id']);
        isSelected[i] = true;
      }
    });
    print(assignedEvaluators);
  }

  @override
  Widget build(BuildContext context) {
    // final allTeams = Provider.of<Auth>(context).allTeams;
    // print(allTeams);
    // bool isNotLoaded = allTeams == null;
    return Scaffold(
      backgroundColor: Color(0xFF030D18),
      body: SafeArea(
        child: _isLoaded
            ? Container(
                color: Color(0xFF030D18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                        left: 20,
                      ),
                      child: Text(
                        'ASSIGN EVALUATORS',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: evaluators['usersCount'],
                      itemBuilder: (ctx, i) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Card(
                          color: Color(0xFF072031),
                          child: ListTile(
                            title: Text(evaluators['data'][i]['fullName']),
                            subtitle: Text(evaluators['data'][i]['userType']),
                            trailing: isSelected[i]
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  )
                                : null,
                            onTap: () => toggleSelection(
                                evaluators['data'][i]['user_id'], i),
                            // selected: isSelected,
                          ),
                        ),
                      ),
                    ),
                    // MultiSelect(
                    //     autovalidate: false,
                    //     titleText: 'Hello',
                    //     validator: (value) {
                    //       if (value == null) {
                    //         return 'Please select one or more option(s)';
                    //       }
                    //     },
                    //     errorText: 'Please select one or more option(s)',
                    //     dataSource: [
                    //       {
                    //         "display": "Australia",
                    //         "value": 1,
                    //       },
                    //       {
                    //         "display": "Canada",
                    //         "value": 2,
                    //       },
                    //       {
                    //         "display": "India",
                    //         "value": 3,
                    //       },
                    //       {
                    //         "display": "United States",
                    //         "value": 4,
                    //       }
                    //     ],
                    //     textField: 'display',
                    //     valueField: 'value',
                    //     filterable: true,
                    //     required: true,
                    //     value: null,
                    //     onSaved: (value) {
                    //       print('The value is $value');
                    //     }),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
