import 'package:flutter/material.dart';
import 'package:nexus/home/tutorial_page/tutorial_page7.dart';

import '../../globalVariable.dart';
class TutorialPage6 extends StatefulWidget {
  const TutorialPage6({Key? key}) : super(key: key);

  @override
  State<TutorialPage6> createState() => _TutorialPage6State();
}

class _TutorialPage6State extends State<TutorialPage6> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset('images/Blogstwo.jpg'),
          Positioned(
            top: MediaQuery.of(context).size.height/1.4,
            child: Padding(
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
                    nextPage(context, TutorialPage7());
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent),
                  child: Text('7/9 Next '),
                ),
              ),
            ),
          ),
        ]
    );
  }
}
