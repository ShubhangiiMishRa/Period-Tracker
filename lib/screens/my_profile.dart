import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:nexus/api/local_storage.dart';
import 'package:nexus/screens/editprofile.dart';
import 'package:nexus/screens/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Authentication/verification_page.dart';
import '../globalVariable.dart';
import '../main.dart';
class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        nextPage(context, const NavigatorPage());
        // Navigator.pop(context);
        return Future.sync(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: (){
              nextPage(context, NavigatorPage());
            },
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xFF0F2F5B),
            ),
          ),
          title: const Text(
            'My Profile',
            style: TextStyle(
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w600,
              fontSize: 18,
              height: 1.33,
              color: Color(0xFF0F2F5B),
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 24, right: 16, left: 16),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: TextStyle(
                      fontFamily: 'mulish',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 13.451,
                      height: 1.14, // equivalent to line-height: 15px
                      letterSpacing: -0.480392,
                      color: Color(0xFF191919),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: FutureBuilder<SharedPreferences>(
                        future: SharedPreferences.getInstance(),
                        builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot){
                          if(snapshot.hasData){
                            String? username = snapshot.data?.getString('name');
                            return Text(
                              '$username',
                              style: TextStyle(
                                fontFamily: 'mulishbold',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                height: 1.14, // equivalent to line-height: 15px
                                letterSpacing: -0.480392,
                                color: Color(0xFF374957),
                              ),
                            );
                          }
                          else
                            return Text('Your Name');
                        }
                      // child: Text(
                      //   LocalStorage.userName,
                      //   style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.w600,
                      //       fontFamily: 'mulish'),
                      // ),
                    ),
                  ),
                  Divider()
                ],
              ),
              SizedBox(height: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: TextStyle(
                      fontFamily: 'mulish',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 13.451,
                      height: 1.14, // equivalent to line-height: 15px
                      letterSpacing: -0.480392,
                      color: Color(0xFF191919),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      prefs.getString(LocalStorage.userEmail)??"Name",
                      style: TextStyle(
                        fontFamily: 'mulishbold',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        height: 1.14, // equivalent to line-height: 15px
                        letterSpacing: -0.480392,
                        color: Color(0xFF374957),
                      ),
                    ),
                  ),
                  Divider()
                ],
              ),
              SizedBox(height: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Phone Number',
                    style: TextStyle(
                      fontFamily: 'mulish',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 13.451,
                      height: 1.14, // equivalent to line-height: 15px
                      letterSpacing: -0.480392,
                      color: Color(0xFF191919),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      prefs.getString(LocalStorage.phoneNumber)??"NA",
                      style: TextStyle(
                        fontFamily: 'mulishbold',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        height: 1.14, // equivalent to line-height: 15px
                        letterSpacing: -0.480392,
                        color: Color(0xFF374957),
                      ),
                    ),
                  ),
                  Divider()
                ],
              ),
              SizedBox(height: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Age',
                    style: TextStyle(
                      fontFamily: 'mulish',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 13.451,
                      height: 1.14, // equivalent to line-height: 15px
                      letterSpacing: -0.480392,
                      color: Color(0xFF191919),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      prefs.getString(LocalStorage.userAge)??"18",
                      style: TextStyle(
                        fontFamily: 'mulishbold',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        height: 1.14, // equivalent to line-height: 15px
                        letterSpacing: -0.480392,
                        color: Color(0xFF374957),
                      ),
                    ),
                  ),
                  Divider()
                ],
              ),
              SizedBox(height: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Are You Sexually Active?',
                    style: TextStyle(
                      fontFamily: 'mulish',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 13.451,
                      height: 1.14, // equivalent to line-height: 15px
                      letterSpacing: -0.480392,
                      color: Color(0xFF191919),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      prefs.getString(LocalStorage.userSexualActivity)??"NO",
                      style: TextStyle(
                        fontFamily: 'mulishbold',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        height: 1.14, // equivalent to line-height: 15px
                        letterSpacing: -0.480392,
                        color: Color(0xFF374957),
                      ),
                    ),
                  ),
                  Divider()
                ],
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'First Day of Last Cycle',
                        style: TextStyle(
                          fontFamily: 'mulish',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.451,
                          height: 1.14, // equivalent to line-height: 15px
                          letterSpacing: -0.480392,
                          color: Color(0xFF191919),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Text(
                          prefs.getString(LocalStorage.userFirstDay)??DateTime.now().toString(),
                          style: TextStyle(
                            fontFamily: 'mulishbold',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            height: 1.14, // equivalent to line-height: 15px
                            letterSpacing: -0.480392,
                            color: Color(0xFF374957),
                          ),
                        ),
                      ),
                      Divider()
                    ],
                  ),),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Number of Days In Cycle',
                        style: TextStyle(
                          fontFamily: 'mulish',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.451,
                          height: 1.14, // equivalent to line-height: 15px
                          letterSpacing: -0.480392,
                          color: Color(0xFF191919),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 16),
                        child: Text(
                          prefs.getString(LocalStorage.userDaysInCycle)??"28",
                          style: TextStyle(
                            fontFamily: 'mulishbold',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            height: 1.14, // equivalent to line-height: 15px
                            letterSpacing: -0.480392,
                            color: Color(0xFF374957),
                          ),
                        ),
                      ),
                      Divider()
                    ],
                  ),)
                ],
              ),
              SizedBox(height: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Number Of Day Period Flow',
                    style: TextStyle(
                      fontFamily: 'mulish',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 13.451,
                      height: 1.14, // equivalent to line-height: 15px
                      letterSpacing: -0.480392,
                      color: Color(0xFF191919),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      prefs.getString(LocalStorage.userFlowDuration)??"6",
                      style: TextStyle(
                        fontFamily: 'mulishbold',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        height: 1.14, // equivalent to line-height: 15px
                        letterSpacing: -0.480392,
                        color: Color(0xFF374957),
                      ),
                    ),
                  ),
                  Divider()
                ],
              ),
              Container(
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
                    nextPage(context, EditProfile());
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent),
                  child: Text('Edit'),
                ),
              ),
              SizedBox(height: 15,),
            ],
          ),
        ),
      ),
    );
  }
}
