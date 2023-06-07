import 'package:flutter/material.dart';
import 'package:nexus/home/tutorial_page/tutorial_page4.dart';

import '../../globalVariable.dart';
class TutorialPage3 extends StatefulWidget {
  const TutorialPage3({Key? key}) : super(key: key);

  @override
  State<TutorialPage3> createState() => _TutorialPage3State();
}

class _TutorialPage3State extends State<TutorialPage3> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.sync(() => false),
      child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset('images/periods_log.jpg'),
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
                    nextPage(context, TutorialPage4());
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent),
                  child: Text('4/9 Next '),
                ),
              ),
            ),
          ]
      ),
    );
  }
}
