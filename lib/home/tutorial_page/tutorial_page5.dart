import 'package:flutter/material.dart';
import 'package:nexus/home/tutorial_page/tutorial_page6.dart';

import '../../globalVariable.dart';
class TutorialPage5 extends StatefulWidget {
  const TutorialPage5({Key? key}) : super(key: key);

  @override
  State<TutorialPage5> createState() => _TutorialPage5State();
}

class _TutorialPage5State extends State<TutorialPage5> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset('images/Blogs.jpg'),
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
                  nextPage(context, TutorialPage6());
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent),
                child: Text('6/9 Next '),
              ),
            ),
          ),
        ]
    );
  }
}
