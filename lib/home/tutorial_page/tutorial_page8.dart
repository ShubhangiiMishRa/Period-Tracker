import 'package:flutter/material.dart';
import 'package:nexus/home/home_page.dart';
import 'package:nexus/screens/navigation.dart';

import '../../globalVariable.dart';
import '../home_page2.dart';
import '../testPage.dart';
class TutorialPage8 extends StatefulWidget {
  const TutorialPage8({Key? key}) : super(key: key);

  @override
  State<TutorialPage8> createState() => _TutorialPage8State();
}

class _TutorialPage8State extends State<TutorialPage8> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset('images/Calender.jpg'),
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
                  nextPage(context, NavigatorPage());
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent),
                child: Text('9/9 Next '),
              ),
            ),
          ),
        ]
    );
  }
}
