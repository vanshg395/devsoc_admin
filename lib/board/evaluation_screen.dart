import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class EvaluationScreen extends StatefulWidget {
  @override
  _EvaluationScreenState createState() => _EvaluationScreenState();
}

class _EvaluationScreenState extends State<EvaluationScreen> {
  @override
  Widget build(BuildContext context) {
    final userDetails = Provider.of<Auth>(context).teamInfo;
    bool isNotLoaded = userDetails == null;
    return SafeArea(
      child: Container(
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
                'EVALUATE',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'MY TEAMS',
                style: TextStyle(
                  fontSize: 24,
                  letterSpacing: 2,
                  fontFamily: 'SFProTextSemibold',
                ),
              ),
            ),
            isNotLoaded
                ? Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          Colors.blue,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: userDetails['data'].length == 0
                        ? Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                'No Teams have been added for you. Please contact our Team.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: (ctx, i) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              child: Card(
                                color: Color(0xFF072031),
                                child: ListTile(
                                  title: Text(
                                    userDetails['data'][i]['team']['team_name'],
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'SFProTextSemiMed',
                                    ),
                                  ),
                                  subtitle: Text(
                                    userDetails['data'][i]['team']['track'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'SFProDisplayLight',
                                    ),
                                  ),
                                  leading: CircleAvatar(
                                    child: Text(userDetails['data'][i]['team']
                                            ['team_number']
                                        .toString()),
                                  ),
                                ),
                              ),
                            ),
                            itemCount: userDetails['data'].length,
                          ),
                  ),
            // SizedBox(
            //   height: 20,
            // ),
            // BoardList(),
            // SizedBox(
            //   height: 30,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20.0),
            //   child: Text(
            //     'SPONSORS',
            //     style: TextStyle(
            //       fontSize: 14,
            //       fontFamily: 'SFProDisplayMed',
            //       color: Colors.grey,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 40),
            //   alignment: Alignment.center,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     color: Color(0xFF072031),
            //   ),
            //   child: Image.asset('assets/img/others/sponsors.png'),
            // ),
            // SizedBox(
            //   height: 30,
            // ),
          ],
        ),
      ),
    );
  }
}
