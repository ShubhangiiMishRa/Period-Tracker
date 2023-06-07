import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nexus/home/tutorial_page/tutorial_page1.dart';
import 'package:nexus/home/tutorial_page/tutorial_page2.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Authentication/verification_page.dart';
import '../../globalVariable.dart';

class Tut_page extends StatefulWidget {
  const Tut_page({Key? key}) : super(key: key);

  @override
  State<Tut_page> createState() => _Tut_pageState();
}

class _Tut_pageState extends State<Tut_page> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.sync(() => false),
      child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset('images/home.jpg'),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  width: 343,
                  height: 48,
                  margin: EdgeInsets.only(left: 0, top: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFDC3D8E), Color(0xFFAC4DBA)],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      nextPage(context, TutorialPage2());
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: Text('1/9 Next '),
                  ),
                ),
            ),
          ]
      ),
    );
  }
}
