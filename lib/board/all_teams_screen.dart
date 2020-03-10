import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './team_info.dart';
import '../providers/auth.dart';
import './teamInfoCore.dart';

class AllTeamsScreen extends StatefulWidget {
  @override
  _AllTeamsScreenState createState() => _AllTeamsScreenState();
}

class _AllTeamsScreenState extends State<AllTeamsScreen> {
  // @override
  // void initState() {
  //   Future.delayed(Duration.zero, () async {
  //     await Provider.of<Auth>(context, listen: false).getAllTeams();
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final allTeams = Provider.of<Auth>(context).allTeams;
    print(allTeams);
    bool isNotLoaded = allTeams == null;
    return SafeArea(
      child: Container(
        color: Color(0xFF030D18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'evalHead',
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 20,
                ),
                child: Text(
                  'ALL TEAMS',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            SizedBox(
              height: 30,
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
                : ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (ctx, i) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 2,
                      ),
                      child: Card(
                        color: Color(0xFF072031),
                        child: ListTile(
                          onTap: () {
                            if (Provider.of<Auth>(context).userTypeText ==
                                'Core-2nd Year') {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TeamInfoCore(allTeams[i]['id']),
                                ),
                              );
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TeamInfo(allTeams[i]['id']),
                                ),
                              );
                            }
                          },
                          title: Hero(
                            tag: allTeams[i]['id'],
                            child: Text(
                              allTeams[i]['team_name'],
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'SFProTextSemiMed',
                              ),
                            ),
                          ),
                          // subtitle: Text(
                          //   userDetails['data'][i]['track'] ??
                          //       'abc',
                          //   style: TextStyle(
                          //     fontSize: 14,
                          //     fontFamily: 'SFProDisplayLight',
                          //   ),
                          // ),
                          leading: CircleAvatar(
                            child: Text(
                              allTeams[i]['team_number'].toString(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    itemCount: allTeams.length,
                  ),
          ],
        ),
      ),
    );
  }
}
