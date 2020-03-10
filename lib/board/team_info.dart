import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../providers/auth.dart';
import './evaluation.dart';
import 'dart:convert';
import 'dart:wasm';

class TeamInfo extends StatefulWidget {
  @override
  _TeamInfoState createState() => _TeamInfoState();

  final String teamId;
  TeamInfo(this.teamId);
}

class _TeamInfoState extends State<TeamInfo> {
  bool _isLoaded = false;
  Map<String, dynamic> _teamData;
      
  
  @override
  void initState() {
    String _token=Provider.of<Auth>(context, listen: false).token;
    getInfo(_token);
    super.initState();
  }

  Future<void> getInfo(_token) async {
    // write direct http code here for getting team info using id and store in _teamData.
    String url = 'https://api-devsoc.herokuapp.com/team/info/${widget.teamId}';

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': _token},
        );
      print(response.body);
      final responseBody = json.decode(response.body);
      _teamData = responseBody;
      print(_teamData);
      print('Length :'+_teamData['teamInfo']['members'].length);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF030D18),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              color: Color(0xFF030D18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                    ),
                    child: Hero(
                      tag: widget.teamId,
                      child: Text(
                        'Team Info', // replace with dynamic teamName
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10,20,10,20),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[200],
                      borderRadius:BorderRadius.circular(25.0)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      
                      children:<Widget>[
                        Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Team Name: ${_teamData['teamInfo']['team_name']}",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                        ),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Team Number: ${_teamData['teamInfo']['team_number']}",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Team Idea: ${_teamData['teamInfo']['idea']}",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Team Leader: ${_teamData['teamInfo']['team_leader']}",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Phone: ${_teamData['teamInfo']['team_leader_phone']}",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Team Members : ",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0,left:20),
                        child:_teamData['teamInfo']['members'] == null ? Text('NO TEAM MATES',
                          style: Theme.of(context).textTheme.headline6.copyWith(
                          fontSize: 18,
                          color: Colors.red

                        )
                      ) 
                        : ListView.builder(
                            itemCount: _teamData['teamInfo']['members'].length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return  Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text(
                                "$index ,${_teamData['teamInfo']['members'][index]}",
                                style: Theme.of(context).textTheme.headline6.copyWith(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                                )
                              );
                            }
                                )
                            
                        ), 

                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Track: ${_teamData['teamInfo']['track']}",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Status: ${_teamData['teamInfo']['status']}",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                        ),
                      ),
                      ]
                    )
                  ),
                  SizedBox(
                    height:30
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10,20,10,20),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[200],
                      borderRadius:BorderRadius.circular(25.0)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:<Widget>[
                        Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Round 1 Info",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(
                        height:10
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:<Widget>[
                        Padding(
                        padding: const EdgeInsets.only(top: 15.0,left:10),
                        child: _teamData['round1Eval']['data'] == null ? Text('No Evaluations in Round 1',
                          style: Theme.of(context).textTheme.headline6.copyWith(
                          fontSize: 16,
                          color: Colors.red
                        )
                      ) 
                        : ListView.builder(
                            shrinkWrap:true,
                            scrollDirection: Axis.vertical,
                            itemCount: _teamData['round1Eval']['data'].length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return  Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Card(
                                  color: Colors.blueGrey[300],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left:15,top:15),
                                        child: Text(
                                          "Eval Name: ${_teamData['round1Eval']['data'][index]['evalName']}",
                                          style: Theme.of(context).textTheme.headline6.copyWith(
                                                fontSize: 18,
                                color: Colors.black,
                              ),
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:15,top:15),
                                        child: Text(
                                          "Level: ${_teamData['round1Eval']['data'][index]['userType']}",
                                          style: Theme.of(context).textTheme.headline6.copyWith(
                                                fontSize: 18,
                                color: Colors.black,
                              ),
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:15,top:15),
                                        child: Text(
                                          "Novelty: ${_teamData['round1Eval']['data'][index]['novelty_slider']}",
                                          style: Theme.of(context).textTheme.headline6.copyWith(
                                                fontSize: 18,
                                color: Colors.black,
                              ),
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:15,top:15),
                                        child: Text(
                                          "Feasability: ${_teamData['round1Eval']['data'][index]['tech_feasability_slider']}",
                                          style: Theme.of(context).textTheme.headline6.copyWith(
                                                fontSize: 18,
                                color: Colors.black,
                              ),
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          maxLines: 1,
                                        ),
                                      ),Padding(
                                        padding: const EdgeInsets.only(left:15,top:15),
                                        child: Text(
                                          "Impact: ${_teamData['round1Eval']['data'][index]['impact_slider']}",
                                          style: Theme.of(context).textTheme.headline6.copyWith(
                                                fontSize: 18,
                                color: Colors.black,
                              ),
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:15,top:15),
                                        child: Text(
                                          "Presentation Quality: ${_teamData['round1Eval']['data'][index]['presentation_quality_slider']}",
                                          style: Theme.of(context).textTheme.headline6.copyWith(
                                                fontSize: 18,
                                color: Colors.black,
                              ),
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:15,top:15),
                                        child: Text(
                                          "Bussiness Model: ${_teamData['round1Eval']['data'][index]['bussiness_model_slider']}",
                                          style: Theme.of(context).textTheme.headline6.copyWith(
                                                fontSize: 18,
                                color: Colors.black,
                              ),
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:15,top:15),
                                        child: Text(
                                          "Scalability: ${_teamData['round1Eval']['data'][index]['scalability_slider']}",
                                          style: Theme.of(context).textTheme.headline6.copyWith(
                                                fontSize: 18,
                                color: Colors.black,
                              ),
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:15,top:15),
                                        child: Text(
                                          "Remarks: ${_teamData['round1Eval']['data'][index]['remarks']}",
                                          style: Theme.of(context).textTheme.headline6.copyWith(
                                                fontSize: 18,
                                color: Colors.black,
                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:15,top:15),
                                        child: Text(
                                          "Notes: ${_teamData['round1Eval']['data'][index]['remarks']}",
                                          style: Theme.of(context).textTheme.headline6.copyWith(
                                                fontSize: 18,
                                color: Colors.black,
                              ),
                                        ),
                                      ),Padding(
                                        padding: const EdgeInsets.only(left:15,top:15),
                                        child: Text(
                                          "Suggestions Given: ${_teamData['round1Eval']['data'][index]['suggesstions_given']}",
                                          style: Theme.of(context).textTheme.headline6.copyWith(
                                                fontSize: 18,
                                color: Colors.black,
                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              );
                            }
                          )
                            
                        ), 

                      ]
                      )


                      ]
                      )
                  ),


                  SizedBox(
                    height:30
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10,20,10,20),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[200],
                      borderRadius:BorderRadius.circular(25.0)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:<Widget>[
                        Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Round 2 Info",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(
                        height:10
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:<Widget>[
                        Padding(
                        padding: const EdgeInsets.only(top: 15.0,left:20),
                        child: _teamData['round2Eval']['data'] == null ? Text('No Evaluations in Round 2',
                          style: Theme.of(context).textTheme.headline6.copyWith(
                          fontSize: 16,
                          color: Colors.red
                        )
                      ) 
                        : ListView.builder(
                            shrinkWrap:true,
                            scrollDirection: Axis.vertical,
                            itemCount: _teamData['round2Eval']['data'].length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return  Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Card(
                                  color: Colors.blueGrey[300],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left:5,top:15),
                                        child: Text(
                                          "Eval Name: ${_teamData['round2Eval']['data'][index]['evalName']}",
                                          style: Theme.of(context).textTheme.headline6.copyWith(
                                                fontSize: 18,
                                color: Colors.black,
                              ),
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:15,top:15),
                                        child: Text(
                                          "Level: ${_teamData['round2Eval']['data'][index]['userType']}",
                                          style: Theme.of(context).textTheme.headline6.copyWith(
                                                fontSize: 18,
                                color: Colors.black,
                              ),
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:15,top:15),
                                        child: Text(
                                          "Novelty: ${_teamData['round2Eval']['data'][index]['novelty_slider']}",
                                          style: Theme.of(context).textTheme.headline6.copyWith(
                                                fontSize: 18,
                                color: Colors.black,
                              ),
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:15,top:15),
                                        child: Text(
                                          "Feasability: ${_teamData['round2Eval']['data'][index]['tech_feasability_slider']}",
                                          style: Theme.of(context).textTheme.headline6.copyWith(
                                                fontSize: 18,
                                color: Colors.black,
                              ),
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          maxLines: 1,
                                        ),
                                      ),Padding(
                                        padding: const EdgeInsets.only(left:15,top:15),
                                        child: Text(
                                          "Impact: ${_teamData['round2Eval']['data'][index]['impact_slider']}",
                                          style: Theme.of(context).textTheme.headline6.copyWith(
                                                fontSize: 18,
                                color: Colors.black,
                              ),
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:15,top:15),
                                        child: Text(
                                          "Presentation Quality: ${_teamData['round2Eval']['data'][index]['presentation_quality_slider']}",
                                          style: Theme.of(context).textTheme.headline6.copyWith(
                                                fontSize: 18,
                                color: Colors.black,
                              ),
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:15,top:15),
                                        child: Text(
                                          "Bussiness Model: ${_teamData['round2Eval']['data'][index]['bussiness_model_slider']}",
                                          style: Theme.of(context).textTheme.headline6.copyWith(
                                                fontSize: 18,
                                color: Colors.black,
                              ),
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:15,top:15),
                                        child: Text(
                                          "Scalability: ${_teamData['round2Eval']['data'][index]['scalability_slider']}",
                                          style: Theme.of(context).textTheme.headline6.copyWith(
                                                fontSize: 18,
                                color: Colors.black,
                              ),
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:15,top:15),
                                        child: Text(
                                          "Remarks: ${_teamData['round2Eval']['data'][index]['remarks']}",
                                          style: Theme.of(context).textTheme.headline6.copyWith(
                                                fontSize: 18,
                                color: Colors.black,
                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:15,top:15),
                                        child: Text(
                                          "Notes: ${_teamData['round2Eval']['data'][index]['remarks']}",
                                          style: Theme.of(context).textTheme.headline6.copyWith(
                                                fontSize: 18,
                                color: Colors.black,
                              ),
                                        ),
                                      ),Padding(
                                        padding: const EdgeInsets.only(left:15,top:15),
                                        child: Text(
                                          "Suggestions Given: ${_teamData['round2Eval']['data'][index]['suggesstions_given']}",
                                          style: Theme.of(context).textTheme.headline6.copyWith(
                                                fontSize: 18,
                                color: Colors.black,
                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              );
                            }
                          )
                            
                        ), 

                      ]
                      )


                      ]
                      )
                  ),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
