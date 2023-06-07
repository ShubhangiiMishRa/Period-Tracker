import 'package:flutter/material.dart';
import 'package:nexus/home/tutorial_page/tutorial_page2.dart';
import 'package:nexus/home/tutorial_page/tutorial_page5.dart';

import '../../globalVariable.dart';
class TutorialPage4 extends StatefulWidget {
  const TutorialPage4({Key? key}) : super(key: key);

  @override
  State<TutorialPage4> createState() => _TutorialPage4State();
}

class _TutorialPage4State extends State<TutorialPage4> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset('images/period_History.jpg'),
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
                  nextPage(context, TutorialPage5());
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent),
                child: Text('5/9 Next '),
              ),
            ),
          ),
        ]
    );
  }
}
