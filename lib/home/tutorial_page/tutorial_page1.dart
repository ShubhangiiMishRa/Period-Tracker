import 'package:flutter/material.dart';
import 'package:nexus/home/tutorial_page/tutorial_page2.dart';
import 'package:nexus/home/tutorial_page/tutorial_page3.dart';

import '../../globalVariable.dart';
class TutorialPage1 extends StatefulWidget {
  const TutorialPage1({Key? key}) : super(key: key);

  @override
  State<TutorialPage1> createState() => _TutorialPage1State();
}

class _TutorialPage1State extends State<TutorialPage1> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.sync(() => false),
      child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset('images/home_two.jpg'),
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
                    nextPage(context, TutorialPage3());
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent),
                  child: Text('3/9 Next '),
                ),
              ),
            ),
          ]
      ),
    );
  }
}
