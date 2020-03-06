import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './login_screen.dart';
import './splash_screen.dart';
import './providers/auth.dart';
import './board/tabsScreen.dart';
import './judge/tabsScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Auth(),
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          theme: ThemeData.light().copyWith(
            textTheme: TextTheme(
              headline1: TextStyle(
                fontSize: 30,
                letterSpacing: 5,
                fontFamily: 'SFProTextSemibold',
              ),
            ),
          ),
          home: auth.isAuth
              ? ((auth.userType == 1)
                  ? JudgeScreen()
                  : (auth.userType == 2) ? BoardScreen() : null)
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, res) =>
                      res.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : LoginScreen(),
                ),
        ),
      ),
    );
  }
}
