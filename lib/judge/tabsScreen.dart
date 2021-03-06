import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

import './profile_screen.dart';
import './timeline_screen.dart';
import './about_us_screen.dart';
import './evaluation_screen.dart';

class JudgeScreen extends StatefulWidget {
  @override
  _JudgeScreenState createState() => _JudgeScreenState();
}

class _JudgeScreenState extends State<JudgeScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': TimelineScreen(),
        'title': 'Timeline',
      },
      {
        'page': EvaluationScreen(),
        'title': 'Speaker',
      },
      {
        'page': AboutUsScreen(),
        'title': 'About Us',
      },
      {
        'page': EssentialsScreen(),
        'title': 'Essentials',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('JudgeType');
    return Scaffold(
      backgroundColor: Color(0xFF030D18),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: _pages[_selectedPageIndex]['page'],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Color(0xFF072031),
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/img/icons/timeline.svg',
              height: 23,
              color: Colors.grey,
            ),
            activeIcon: SvgPicture.asset(
              'assets/img/icons/timeline.svg',
              height: 23,
              color: Color(0xff3284ff),
            ),
            title: SizedBox(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/img/icons/speaker.svg',
              height: 23,
              color: Colors.grey,
            ),
            activeIcon: SvgPicture.asset(
              'assets/img/icons/speaker.svg',
              height: 23,
              color: Color(0xff3284ff),
            ),
            title: SizedBox(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/img/icons/support.svg',
              height: 23,
              color: Colors.grey,
            ),
            activeIcon: SvgPicture.asset(
              'assets/img/icons/support.svg',
              height: 23,
              color: Color(0xff3284ff),
            ),
            title: SizedBox(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/img/icons/user.svg',
              height: 23,
              color: Colors.grey,
            ),
            activeIcon: SvgPicture.asset(
              'assets/img/icons/user.svg',
              height: 23,
              color: Color(0xff3284ff),
            ),
            title: SizedBox(),
          ),
        ],
      ),
    );
  }
}
