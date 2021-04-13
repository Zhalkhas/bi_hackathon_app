import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:hackathon_bi_musorapp/info.dart';
import 'package:hackathon_bi_musorapp/submit.dart';
import 'package:hackathon_bi_musorapp/tracking.dart';

import 'rating.dart';

class AppHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  List<Widget> widgets = [];

  int currentTab = 0;

  @override
  void initState() {
    super.initState();
    widgets.add(Info());
    widgets.add(SubmitWidget());
    widgets.add(Rating());
    widgets.add(TrashTracking());
  }

  @override
  Widget build(BuildContext context) {
    print("fid ${FirebaseAuth.instance.currentUser.uid}");

    return Scaffold(
      body: SafeArea(child: widgets[currentTab]),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: currentTab,
        onTap: (value) => setState(
          () => currentTab = value,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesome5.info_circle),
            label: 'Информация',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesome5.recycle),
            label: 'Сдача мусора',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesome.star),
            label: 'Рейтинг',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesome5.search_location),
            label: 'Трекинг',
          ),
        ],
      ),
    );
  }
}
