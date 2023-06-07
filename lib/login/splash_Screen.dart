import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nexus/login/landing_page.dart';
import 'package:nexus/screens/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../globalVariable.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String  KEYLOGIN = "Login";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: GradientText(
            'Health App',
            style: TextStyle(
                fontFamily: 'alexbrush',
                fontWeight: FontWeight.bold,
                fontSize: 60),
            gradientType: GradientType.linear,
            gradientDirection: GradientDirection.ttb,
            colors: [Color(0xffdc3d83), Color(0xffac4dba)],
          )),
    );
  }

  Future<void> firstScreen() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(KEYLOGIN);


    Timer(Duration(seconds: 2),(){
      if(isLoggedIn != null){
        if(isLoggedIn){
          nextPage(context, NavigatorPage());
        }
        else{
          nextPage(context, LandingPage());
        }
      }
      else{
        nextPage(context, LandingPage());
      }
    }
    );
  }
}
