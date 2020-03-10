import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import './evaluation.dart';

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
    getInfo();
    super.initState();
  }

  Future<void> getInfo() async {
    // write direct http code here for getting team info using id and store in _teamData.
    setState(() {
      _isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF030D18),
      body: SafeArea(
        child: Container(
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
                    'A1', // replace with dynamic teamName
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
            ],
          ),
        ),
      ),
    );
  }
}
