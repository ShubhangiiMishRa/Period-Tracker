import 'dart:math';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nexus/Authentication/login_page.dart';
import 'package:nexus/api/local_storage.dart';
import 'package:nexus/screens/history_page.dart';
import 'package:nexus/screens/my_profile.dart';
import 'package:nexus/util/colors.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';
import '../api/userdata.dart';
import '../globalVariable.dart';
import '../login/landing_page.dart';
import '../login/splash_Screen.dart';
import '../main.dart';
import '../screens/periods_log.dart';

class HomePage2 extends StatefulWidget {
  double pi = 3.1415926535897932;
  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  // DateTime? selectedDate;
  DateTime now = DateTime.now();
  // late SharedPreferences prefs;
  // int? position;
  Random random = new Random();
  @override
  void initState() {

    customPrint("numberOfDaysInCycle 2:: ${UserData.numberOfDaysInCycle}");
    customPrint("flowDays 2 :: ${UserData.flowDays}");
    customPrint("periodStartDate 2:: ${UserData.periodStartDate}");
    customPrint("prevDate 2:: ${UserData.prevDate}");
    customPrint("nextDate 2:: ${UserData.nextDate}");
    customPrint("prefs.getString(LocalStorage.userFirstDay) 2:: ${prefs.getString(LocalStorage.userFirstDay)}");
    setState(() {
      // selectedDate = DateTime.now().add(Duration(days: 2));
    });
    super.initState();
  }
  // DateTime prevDate = UserData.periodStartDate.subtract(Duration(days: (UserData.numberOfDaysInCycle + UserData.flowDays)));
  // DateTime nextDate = UserData.periodStartDate.add( Duration(days: UserData.numberOfDaysInCycle + UserData.flowDays));
  // DateFormat dateFormat = DateFormat.MMMM().format(prevDate);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xffFBFBFB),
        drawer: Drawer(
          child: ListView(
            children: [
              Container(
                height: 190,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(9.60784),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xffdc3d83), Color(0xffac4dba)])),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Health App',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'alexbrush',
                            fontWeight: FontWeight.w600,
                            fontSize: 40),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Text(
                        prefs.getString(LocalStorage.userName).toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'mulish'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        prefs.getString(LocalStorage.phoneNumber).toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'mulish'),
                      )
                    ],
                  ),
                ), //declare your widget here
              ),
              SizedBox(
                height: 30,
              ),
              ListTile(
                leading: Icon(Icons.account_circle_outlined),
                title: const Text(
                  'My profile',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'mulish'),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 17,
                ),
                onTap: () {
                  nextPage(context, MyProfile());
                },
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: const Text(
                  'History',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'mulish'),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 17,
                ),
                onTap: () {
                  customPrint("selectedDate 2 :: ${selectedDate}");
                  nextPage(context, HistoryPage());
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: const Text(
                  'Log out',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'mulish'),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 17,
                ),
                onTap: () {
                  logoutUser(context);
                },
              ),
            ],
          ),
        ),
        body: Obx(() {
          customPrint("new data  UserData.flowDays.value :: ${ UserData.flowDays.value}");
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(children: [


                  CalendarAppBar(
                    locale: 'en',
                    backButton: false,
                    white: Color(0xffdc3d83),
                    selectedDate: selectedDate,
                    accent: Colors.white,
                    onDateChanged: (value) =>
                        setState(() => selectedDate = value),
                    // firstDate: DateTime.now().subtract(Duration(days: 2)),
                    // lastDate: DateTime.now().add(Duration(days: 2)),
                    lastDate: DateTime.now(),
                    events: List.generate(10, (index) => DateTime.now()),
                  ),
                  Positioned(
                    top: 40,
                    left: 10,
                    child: IconButton(
                      // onPressed: () {
                      //   customPrint("new data  UserData.flowDays.value :: ${ UserData.flowDays.value}");
                      // },
                      onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                      icon: Image.asset('icons/add.jpg'),
                    ),
                  ),
                  Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: GradientText(
                          'Health App',
                          style: TextStyle(
                              fontFamily: 'alexbrush',
                              fontWeight: FontWeight.bold,
                              fontSize: 40),
                          gradientType: GradientType.linear,
                          gradientDirection: GradientDirection.ttb,
                          colors: [Color(0xffdc3d83), Color(0xffac4dba)],
                        ),
                      ))
                ]),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Container(
                    // height: MediaQuery.of(context).size.height / 11,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.60784),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xffdc3d83), Color(0xffac4dba)])),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (UserData.periodStartDate.isBefore(DateTime.now()) &&
                                  UserData.periodStartDate.add(Duration(days: UserData.flowDays.value)).isBefore(DateTime.now()))
                                  ? Text(UserData.prevDate.day.toString() + " " + DateFormat("MMMM").format(UserData.prevDate),
                                // UserData.periodStartDate.day.toString() + " " + DateFormat("MMMM").format(UserData.periodStartDate),
                                style: TextStyle(
                                  fontFamily: 'Mulishbold',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 1.33,
                                  color: Colors.white,
                                ),
                              )
                                  : Text(
                                UserData.prevDate.day.toString() +
                                    " " +
                                    DateFormat("MMMM")
                                        .format(UserData.prevDate),
                                style: TextStyle(
                                  fontFamily: 'Mulishbold',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 1.33,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Last period date',
                                style: TextStyle(
                                  fontFamily: 'Mulish',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  height: 1.33,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          Text(
                            '|',
                            style: TextStyle(color: Colors.white),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              UserData.periodStartDate.isAfter(DateTime.now())
                                  ? Text(
                                UserData.periodStartDate.day.toString() +
                                    " " +
                                    DateFormat("MMMM")
                                        .format(UserData.periodStartDate),
                                style: TextStyle(
                                  fontFamily: 'Mulishbold',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 1.33,
                                  color: Colors.white,
                                ),
                              )
                                  : Text(
                                UserData.nextDate.day.toString() +
                                    " " +
                                    DateFormat("MMMM")
                                        .format(UserData.nextDate),
                                style: TextStyle(
                                  fontFamily: 'Mulishbold',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 1.33,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Next period date',
                                style: TextStyle(
                                  fontFamily: 'Mulish',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  height: 1.33,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ), //declare your widget here
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 14),
                  child: Center(
                    child: Transform.rotate(
                      angle: (2 * pi / 30) * UserData.prevDate!.day,
                      child: Stack(
                        children: [
                          CircularStepProgressIndicator(
                            // totalSteps: 28,
                            totalSteps: month(context, DateTime.now()),
                            currentStep: UserData.flowDays.value,
                            stepSize: 10,
                            selectedColor: colorCardRed,
                            unselectedColor: Color(0xffDEDEDE),
                            // padding: pi/9,
                            padding: month(context, DateTime.now()) != 28
                                ? (pi / 10)
                                : (pi / 9),
                            width: 200,
                            height: 200,
                            startingAngle: 0,
                            // arcSize: pi / 2,
                            arcSize: pi * 2,
                          ),
                          CircularStepProgressIndicator(
                            // totalSteps: 28,
                            totalSteps: month(context, DateTime.now()),
                            currentStep: 5,
                            stepSize: 10,
                            selectedColor: colorCardGreen,
                            unselectedColor: Colors.transparent,
                            padding: month(context, DateTime.now()) != 28
                                ? (pi / 10)
                                : (pi / 9),
                            // padding: pi / 10,
                            width: 200,
                            height: 200,
                            // startingAngle: pi/1.4,
                            // startingAngle: month(context, DateTime.now()) == 30
                            //     ? (pi / 1.50)
                            //     : month(context, DateTime.now()) == 31
                            //         ? (pi / 1.55)
                            //         : pi / 1.4,
                            startingAngle: 0.210 * (UserData.flowDays.value + 5 ),
                            arcSize: 3.14 * 2,
                          ),
                          CircularStepProgressIndicator(
                            totalSteps: month(context, DateTime.now()),
                            currentStep: 3,
                            stepSize: 10,
                            selectedColor: colorCardBlue,
                            unselectedColor: Colors.transparent,
                            padding: month(context, DateTime.now()) != 28
                                ? (pi / 10)
                                : (pi / 9),
                            width: 200,
                            height: 200,
                            startingAngle: month(context, DateTime.now()) != 28
                                ? (pi / 2 * 3.6)
                                : (pi / 2 * 3.14),
                            arcSize: 3.14 * 2,
                            child: Center(
                              child: Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  color: (now.isAfter(UserData.periodStartDate
                                      .add(Duration(
                                      days:
                                      UserData.flowDays.value + 4))) &&
                                      now.isBefore(UserData.periodStartDate
                                          .add(Duration(
                                          days: UserData.flowDays.value + 11))))
                                      ? colorCardGreen
                                      : (now.isAfter(UserData.periodStartDate.subtract(Duration(days: 4))) &&
                                      now.isBefore(UserData.periodStartDate))
                                      ?Color(0xFF3EAFD6):Colors.black26,
                                  // Color(0xFF3EAFD6),
                                  borderRadius
                                      : BorderRadius.circular(100),
                                ),
                                child: Transform.rotate(
                                  angle: -(2 * pi / 30) * UserData.prevDate!.day,
                                  child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Latest Period',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xffFFFFFF)),
                                          ),
                                          (UserData.periodStartDate
                                              .isBefore(DateTime.now()) &&
                                              UserData.periodStartDate
                                                  .add(Duration(days: UserData.flowDays.value))
                                                  .isBefore(DateTime.now()))
                                              ? Text(
                                              UserData.periodStartDate.day.toString() +
                                                  " " +
                                                  DateFormat("MMMM")
                                                      .format(UserData.periodStartDate),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xffFFFFFF))
                                          )
                                              : Text(
                                              UserData.prevDate.day.toString() +
                                                  " " +
                                                  DateFormat("MMMM")
                                                      .format(UserData.prevDate),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xffFFFFFF))
                                          ),
                                          // Text(
                                          //     '${UserData.prevDate.day} ${DateFormat('MMMM').format(UserData.prevDate)}',
                                          //     style: TextStyle(
                                          //         fontSize: 16,
                                          //         fontWeight: FontWeight.w600,
                                          //         color: Color(0xffFFFFFF))),
                                        ],
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      nextPage(context, PeriodsLog(selectDateForPeriodsLogs: selectedDate,));
                    },
                    child: SizedBox(
                      width: 140,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'icons/Plus.jpg',
                              height: 25,
                              width: 25,
                            ),
                            Center(
                              child: Text('Period Logs',
                                  style: TextStyle(
                                    color: Colors.black,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Image.asset('icons/redDot.png', height: 8),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'The Period',
                        style: TextStyle(
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          height: 1.33,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Image.asset('icons/blueDot.jpg', height: 8),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'PMS',
                        style: TextStyle(
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          height: 1.33,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 50),
                      Image.asset('icons/yellowDot.jpg', height: 8),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'Fertile Window',
                        style: TextStyle(
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          height: 1.33,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  margin: EdgeInsets.only(left: 17, top: 20, right: 17),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(99, 89, 166, 0.07),
                        blurRadius: 58,
                        offset: Offset(0, 10),
                      ),
                      BoxShadow(
                        color: Color.fromRGBO(99, 89, 166, 0.03),
                        blurRadius: 12.9551,
                      ),
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(255, 232, 232, 1),
                        Color.fromRGBO(219, 77, 70, 1),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('icons/icon1.svg', width: 15),
                      SizedBox(
                        width: 18,
                      ),
                      Text(
                        'Period is due in ${(UserData.numberOfDaysInCycle < UserData.nextDate.difference(DateTime.now()).inDays) ? UserData.periodStartDate.difference(DateTime.now()).inDays : UserData.nextDate.difference(DateTime.now()).inDays} days',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                (now.isAfter(UserData.periodStartDate.subtract(Duration(days: 4))) &&
                    now.isBefore(UserData.periodStartDate))?Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset('images/whitePMS.svg'),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'PMS Days',
                            style: TextStyle(
                                fontFamily: 'Mulishbold',
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF3CD896),
                          Color(0xFF3CB0D8),
                        ],
                        stops: [0.0203, 1.0],
                        transform: GradientRotation(102.28 * pi / 180),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(99, 89, 166, 0.07),
                          offset: Offset(0, 10),
                          blurRadius: 58,
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(99, 89, 166, 0.03),
                          blurRadius: 12.9551,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ):SizedBox(height: 0, width: 0,),
              ],
            ),
          );
        }
        ),
      ),
    );
  }

  // void logoutUser(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text("Logout"),
  //         content: const Text("Are you sure you want to Logout?"),
  //         actions: [
  //           TextButton(
  //             child: const Text(
  //               "Cancel",
  //               style: TextStyle(color: Colors.black54),
  //             ),
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //           ),
  //           TextButton(
  //             child: const Text(
  //               "OK",
  //               style: TextStyle(color: Colors.black),
  //             ),
  //             onPressed: () async {
  //               var sharedPref = await SharedPreferences.getInstance();
  //               sharedPref.setBool(SplashScreenState.KEYLOGIN, false);
  //               // await prefs.setBool(LocalStorage.isLoggedIn, false);
  //               // UserData.isLoggedIn = false;
  //               // await FirebaseAuth.instance.signOut();
  //               // await prefs.clear();
  //               nextPage(context, LoginPage());
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  int month(BuildContext context, DateTime currentMonth) {
    int month = DateTime.now().month;
    List<int> thirtyDays = [4, 6, 9, 11];
    List<int> thirtyOneDays = [1, 3, 5, 7, 8, 10, 12];
    if (thirtyDays.contains(currentMonth.month)) {
      return 30;
    }
    if (thirtyOneDays.contains(currentMonth.month)) {
      return 31;
    } else {
      return 28;
    }
  }
}
