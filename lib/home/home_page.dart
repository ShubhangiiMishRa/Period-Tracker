import 'dart:math';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

import 'package:nexus/api/local_storage.dart';
import 'package:nexus/main.dart';
import 'package:nexus/screens/history_page.dart';
import 'package:nexus/screens/my_profile.dart';
import 'package:nexus/util/colors.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';
// import '../Authentication/login_page.dart';
import '../api/userdata.dart';
import '../globalVariable.dart';
// import '../login/landing_page.dart';
// import '../login/splash_Screen.dart';
import '../screens/periods_log.dart';

class HomePage extends StatefulWidget {
  double pi = 3.1415926535897932;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool periodStarted = false;
  bool periodNotStarted = false;

  // int? position;
  Random random = new Random();
  @override
  void initState() {

    customPrint("numberOfDaysInCycle :: ${UserData.numberOfDaysInCycle}");
    customPrint("flowDays :: ${UserData.flowDays}");
    customPrint("periodStartDate :: ${UserData.periodStartDate}");
    customPrint("prevDate :: ${UserData.prevDate}");
    customPrint("nextDate :: ${UserData.nextDate}");
    customPrint("prefs.getString(LocalStorage.userFirstDay) :: ${prefs.getString(LocalStorage.userFirstDay)}");
    setState(() {
      selectedDate = DateTime.now();
      prefs.getString(LocalStorage.userFirstDay);
      UserData.prevDate;
      UserData.nextDate;
    });
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Color _color1 = Color(0xFFFCEEEB);
  Color _textColor1 = Colors.black;
  Color _color2 = Color(0xFFFCEEEB);
  Color _textColor2 = Colors.black;

  void _changeColors(int container) {
    setState(() {
      if (container == 1) {
        _color1 =
        _color1 == Color(0xFFFCEEEB) ? Colors.pink : Color(0xFFFCEEEB);
        _textColor1 = _textColor1 == Colors.white ? Colors.black : Colors.white;
      } else if (container == 2) {
        _color2 =
        _color2 == Color(0xFFFCEEEB) ? Colors.pink : Color(0xFFFCEEEB);
        _textColor2 = _textColor2 == Colors.white ? Colors.black : Colors.white;
      }
    });
  }

  // Color _color = Color(0xFFFCEEEB);
  // Color _textColor = Colors.black;
  //
  // void _changeColor() {
  //   setState(() {
  //     _color = _color == Color(0xFFFCEEEB)  ? Colors.pink : Color(0xFFFCEEEB);
  //     _textColor = _textColor == Colors.white ? Colors.black : Colors.white;
  //   });
  // }
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
                        prefs.getString(LocalStorage.userName) ?? "NA",
                        // '$username',
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
                        prefs.getString(LocalStorage.phoneNumber) ?? "",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'mulish'),
                      ),
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
                  customPrint("selectedDate :: ${selectedDate}");
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
        body: SingleChildScrollView(
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
                  // events: List.generate(10, (index) => DateTime.now()),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
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
                            // Text(
                            //   // UserData.prevDate.day.toString() +
                            //   //     " " +
                            //   //     DateFormat("MMMM").format(UserData.prevDate),
                            //   '',
                            //   style: TextStyle(
                            //     fontFamily: 'Mulishbold',
                            //     fontWeight: FontWeight.bold,
                            //     fontSize: 18,
                            //     height: 1.33,
                            //     color: Colors.white,
                            //   ),
                            // ),
                            Text(
                              UserData.prevDate.day.toString() +
                                  " " +
                                  DateFormat('MMMM').format(UserData.prevDate),
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
                            Text(
                              "${UserData.nextDate.day} ${DateFormat('MMMM').format(UserData.nextDate)}",
                              // 'UserData.date',
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
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 14),
                  child: Center(
                    child: Transform.rotate(
                      angle: (2 * pi / 30) * UserData.periodStartDate!.day,
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
                                  color: colorCardRed,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Transform.rotate(
                                  angle: -(2 * pi / 30) *
                                      UserData.periodStartDate.day,
                                  child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Period day',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xffFFFFFF)),
                                          ),
                                          Text(
                                              ('${UserData.periodStartDate.day} ${DateFormat('MMMM').format(UserData.periodStartDate)}'),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xffFFFFFF))),
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
                );
              }
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
              Padding(
                padding: const EdgeInsets.only(
                    top: 19, bottom: 36, left: 19, right: 19),
                child: Stack(children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 7,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 0, top: 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(99, 89, 166, 0.07),
                          blurRadius: 10,
                          offset: Offset(0, 10),
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(99, 89, 166, 0.03),
                          blurRadius: 12.9551,
                          spreadRadius: 0,
                          offset: Offset(0, 0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                            left: 18,
                            top: 12,
                          ),
                          child: SvgPicture.asset('images/Icon.svg')),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 18, left: 20, bottom: 16),
                        child: Column(
                          children: [
                            periodStarted
                                ? Text('It\'s your first day of period')
                                : periodNotStarted
                                ? Text('Your period has not started')
                                : Text('Has your period started?'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Visibility(
                                    visible: !periodNotStarted,
                                    child: InkWell(
                                      onTap: () {
                                        _changeColors(1);
                                        periodStarted = !periodStarted;
                                        // periodStarted?prefs.setString(LocalStorage.userFirstDay, DateTime.now().toString()):prefs.setString(LocalStorage.userFirstDay, UserData.periodStartDate.toString());
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: _color1,
                                          borderRadius:
                                          BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          'Yes',
                                          style: TextStyle(color: _textColor1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: !periodStarted,
                                  child: InkWell(
                                    onTap: () {
                                      periodNotStarted = !periodNotStarted;
                                      // periodStarted = !periodStarted;
                                      _changeColors(2);
                                    },
                                    child: Container(
                                      // height:MediaQuery.of(context).size.height/20,
                                      // width: MediaQuery.of(context).size.width/20,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: _color2,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'No, Ask me Later',
                                        style: TextStyle(color: _textColor2),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
