import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nexus/api/userdata.dart';
import 'package:nexus/home/home_page2.dart';
import 'package:nexus/screens/stories.dart';
import 'package:nexus/screens/supportpage.dart';

import '../home/home_page.dart';
import 'calendar_picker.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({Key? key,  this.index = 0}) : super(key: key);

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
  final int index;
}

class _NavigatorPageState extends State<NavigatorPage> {
  int index = 0;
  final screens = [
    (DateTime.now().isBefore(UserData.periodStartDate) || DateTime.now().isAfter(UserData.periodStartDate.add(Duration(days: UserData.flowDays.value +1))))?HomePage2():HomePage(),
    // HomePage(),
    StoriesPage(),
    Calendar(),
    // MonthPickerPage()
    SupportPage()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = widget.index;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.sync(() => false),
      child: Scaffold(
        body: screens[index],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              height: 10,
              indicatorColor: Colors.transparent,
              labelTextStyle: MaterialStateProperty.all(
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              )),
          child: NavigationBar(
            height: 70,
            backgroundColor: Colors.white,
            selectedIndex: index,
            //animationDuration: const Duration(seconds: 1),
            // labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            onDestinationSelected: (index) =>
                setState(() => this.index = index),
            destinations: [
              NavigationDestination(
                icon: SvgPicture.asset(
                  'images/home.svg',
                  color: Colors.grey,
                ),
                label: '',
                selectedIcon: SvgPicture.asset(
                  'images/homef.svg',
                ),
              ),
              NavigationDestination(
                icon: SvgPicture.asset(
                  'images/bar.svg',
                ),
                label: '',
                selectedIcon: SvgPicture.asset(
                  'images/barf.svg',
                ),
              ),
              NavigationDestination(
                icon: SvgPicture.asset(
                  'images/calender.svg',
                ),
                label: '',
                selectedIcon: SvgPicture.asset(
                  'images/calenderf.svg',
                ),
              ),
              NavigationDestination(
                icon: SvgPicture.asset(
                  'images/msg.svg',
                ),
                label: '',
                selectedIcon: SvgPicture.asset(
                  'images/msgf.svg',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
