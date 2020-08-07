import 'package:Apexcalisthenics/app_theme.dart';
import 'package:Apexcalisthenics/custom_drawer/drawer_user_controller.dart';
import 'package:Apexcalisthenics/custom_drawer/home_drawer.dart';
import 'package:Apexcalisthenics/feedback_screen.dart';
import 'package:Apexcalisthenics/help_screen.dart';
import 'package:Apexcalisthenics/invite_friend_screen.dart';
import 'package:flutter/material.dart';

import 'discover/discover_screen.dart';


class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;
  int _selectedIndex = 0;
  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView =  DiscoverScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView:_selectedIndex==2? screenView

            : Center(child: Text("In Progress"),),

            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home,color: Colors.grey),
                activeIcon:   Icon(Icons.home,color: Colors.black),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.update,color: Colors.grey),
                activeIcon:   Icon(Icons.update,color: Colors.black),
                title: Text('Pro'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assistant,color: Colors.grey,),
                activeIcon:   Icon(Icons.assistant,color: Colors.black),
                title: Text('Discover'),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black87,
            onTap:_onItemTapped,
          ),
        ),
      ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView =  DiscoverScreen();
        });
      } else if (drawerIndex == DrawerIndex.Help) {
        setState(() {
          screenView = HelpScreen();
        });
      } else if (drawerIndex == DrawerIndex.FeedBack) {
        setState(() {
          screenView = FeedbackScreen();
        });
      } else if (drawerIndex == DrawerIndex.Invite) {
        setState(() {
          screenView = InviteFriend();
        });
      } else {
        //do in your way......
      }
    }
  }
}
