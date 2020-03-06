import 'package:flutter/material.dart';

class EvaluationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color(0xFF030D18),
        child: SingleChildScrollView(
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
              // ListView.builder(
              //   itemBuilder: (ctx, i) {},
              //   itemCount: null,
              // ),
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
      ),
    );
  }
}
