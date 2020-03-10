import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

import './all_teams_screen.dart';
import './timeline_screen.dart';
import './about_us_screen.dart';
import './evaluation_screen.dart';
import './profile_screen.dart';
import './message.dart';

class BoardScreen extends StatefulWidget {
  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
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
        'page': AllTeamsScreen(),
        'title': 'All Teams',
      },
      // {
      //   'page': AboutUsScreen(),
      //   'title': 'About Us',
      // },
      {
        'page': Message(),
        'title': 'Messages',
      },
      {
        'page': EssentialsScreen(),
        'title': 'Profile',
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
            icon: Icon(
              Icons.view_carousel,
              size: 33,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.view_carousel,
              size: 33,
              color: Color(0xff3284ff),
            ),
            title: SizedBox(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/img/icons/message.svg',
              height: 23,
              color: Colors.grey,
            ),
            activeIcon: SvgPicture.asset(
              'assets/img/icons/message.svg',
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
