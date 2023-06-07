import 'package:flutter/material.dart';
import 'package:nexus/home/tutorial_page/tutorial_page1.dart';
import 'package:nexus/home/tutorial_page/tutorial_page3.dart';

import '../../globalVariable.dart';
class TutorialPage2 extends StatefulWidget {
  const TutorialPage2({Key? key}) : super(key: key);

  @override
  State<TutorialPage2> createState() => _TutorialPage2State();
}

class _TutorialPage2State extends State<TutorialPage2> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.sync(() => false),
      child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset('images/home_three.jpg'),
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
                    nextPage(context, TutorialPage1());
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent),
                  child: Text('2/9 Next '),
                ),
              ),
            ),
          ]
      ),
    );
  }
}
