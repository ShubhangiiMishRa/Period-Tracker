// import 'dart:math';
//
// import 'package:calendar_agenda/calendar_agenda.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:nexus/screens/periods_log.dart';
//
// import '../globalVariable.dart';
//
// class ExamplePage extends StatefulWidget {
//   const ExamplePage({Key? key}) : super(key: key);
//
//   @override
//   _ExamplePageState createState() => _ExamplePageState();
// }
//
// class _ExamplePageState extends State<ExamplePage> {
//   CalendarAgendaController _calendarAgendaControllerAppBar =
//       CalendarAgendaController();
//   CalendarAgendaController _calendarAgendaControllerNotAppBar =
//       CalendarAgendaController();
//
//   late DateTime _selectedDateAppBBar;
//   late DateTime _selectedDateNotAppBBar;
//
//   Random random = new Random();
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedDateAppBBar = DateTime.now();
//     _selectedDateNotAppBBar = DateTime.now();
//   }
//   Color _color = Colors.white;
//   Color _textColor = Colors.black;
//
//   void _changeColor() {
//     setState(() {
//       _color = _color == Colors.white  ? Colors.pink : Colors.white;
//       _textColor = _textColor == Colors.white ? Colors.black : Colors.white;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: [
//           CalendarAgenda(
//             controller: _calendarAgendaControllerNotAppBar,
//             appbar: true,
//             selectedDayPosition: SelectedDayPosition.center,
//             leading: IconButton(
//               icon: Icon(
//                 Icons.arrow_back_ios_new,
//                 color: Colors.black,
//               ),
//               onPressed: () {},
//             ),
//             // selectedDayLogo: ImageProvider<>,
//             calendarBackground: Colors.pink,
//             backgroundColor: Colors.white,
//             dateColor: Colors.pink,
//             calendarEventSelectedColor: Colors.black,
//             weekDay: WeekDay.short,
//             fullCalendarScroll: FullCalendarScroll.horizontal,
//             // fullCalendarDay: WeekDay.short,
//             selectedDateColor: Colors.black,
//             locale: 'en',
//             initialDate: DateTime.now(),
//             calendarEventColor: Colors.pink,
//             firstDate: DateTime.now().subtract(Duration(days: 100)),
//             lastDate: DateTime.now().add(Duration(days: 100)),
//             events: List.generate(100, (index) => DateTime.now()),
//             onDateSelected: (date) {
//               setState(() {
//                 _selectedDateAppBBar = date;
//               });
//             },
//             // calendarLogo: Image.network(
//             //   'https://www.kindpng.com/picc/m/355-3557482_flutter-logo-png-transparent-png.png',
//             //   scale: 5.0,
//             // ),
//             // selectedDayLogo: NetworkImage(
//             //   'https://www.kindpng.com/picc/m/355-3557482_flutter-logo-png-transparent-png.png',
//             //   scale: 15.0,
//             // ),
//           ),
//           Stack(
//             children: [
//               Card(
//                 child: Container(
//                   height: MediaQuery.of(context).size.height / 10,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(9.60784),
//                       gradient: LinearGradient(
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                           colors: [Color(0xffdc3d83), Color(0xffac4dba)])),
//                   child: Container(), //declare your widget here
//                 ),
//               ),
//               Positioned(
//                   top: 25,
//                   left: 30,
//                   child: Text(
//                     '8 december',
//                     style: TextStyle(
//                       fontFamily: 'Mulish',
//                       fontWeight: FontWeight.w600,
//                       fontSize: 18,
//                       height: 1.33,
//                       color: Colors.white,
//                     ),
//                   )),
//               Positioned(
//                   top: 50,
//                   left: 30,
//                   child: Text(
//                     'Last period date',
//                     style: TextStyle(
//                       fontFamily: 'Mulish',
//                       fontWeight: FontWeight.w400,
//                       fontSize: 12,
//                       height: 1.33,
//                       color: Colors.white,
//                     ),
//                   )),
//               Positioned(
//                   top: 50,
//                   left: MediaQuery.of(context).size.width / 2,
//                   child: Text(
//                     '|',
//                     style: TextStyle(
//                       fontFamily: 'Mulish',
//                       fontWeight: FontWeight.w600,
//                       fontSize: 12,
//                       height: 1.33,
//                       color: Colors.white,
//                     ),
//                   )),
//               Positioned(
//                   top: 25,
//                   right: 30,
//                   child: Text(
//                     '9 January',
//                     style: TextStyle(
//                       fontFamily: 'Mulish',
//                       fontWeight: FontWeight.w600,
//                       fontSize: 18,
//                       height: 1.33,
//                       color: Colors.white,
//                     ),
//                   )),
//               Positioned(
//                   top: 50,
//                   right: 30,
//                   child: Text(
//                     'Next period date',
//                     style: TextStyle(
//                       fontFamily: 'Mulish',
//                       fontWeight: FontWeight.w400,
//                       fontSize: 12,
//                       height: 1.33,
//                       color: Colors.white,
//                     ),
//                   )),
//             ],
//           ),
//           Stack(children: [
//             Center(
//               child: Container(
//                 width: 174.81,
//                 height: 174.81,
//                 margin: EdgeInsets.all(40),
//                 decoration: BoxDecoration(
//                   color: Color(0xFFF92A2A),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color.fromRGBO(249, 42, 42, 0.25),
//                       blurRadius: 50.8157,
//                       spreadRadius: 0,
//                       offset: Offset(0, 0),
//                     ),
//                   ],
//                   borderRadius: BorderRadius.circular(150),
//                 ),
//               ),
//             ),
//             new Positioned(
//               child: Icon(Icons.circle, size: 15, color: Color(0xFFF92A2A)),
//               top: 25.0,
//               left: 130.0,
//             ),
//           ]),
//           Container(
//             height: 40.0,
//             width: 140,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.white10.withOpacity(0.4),
//                   spreadRadius: 4,
//                   blurRadius: 10,
//                   offset: Offset(0, 3),
//                 )
//               ],
//               borderRadius: const BorderRadius.all(Radius.circular(100.0)),
//             ),
//             child: ElevatedButton(
//               onPressed: () {
//                 nextPage(context, PeriodsLog());
//               },
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xffFFFFFF),
//                   shadowColor: Colors.transparent),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Image.asset(
//                     'icons/Plus.jpg',
//                     height: 25,
//                     width: 25,
//                   ),
//                   Text('Period Logs',
//                       style: TextStyle(
//                         color: Colors.black,
//                       )),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 40,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25),
//             child: Row(
//               children: [
//                 Image.asset('icons/redDot.png', height: 8),
//                 SizedBox(
//                   width: 3,
//                 ),
//                 Text(
//                   'The Period',
//                   style: TextStyle(
//                     fontFamily: 'Mulish',
//                     fontWeight: FontWeight.w600,
//                     fontSize: 12,
//                     height: 1.33,
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 50,
//                 ),
//                 Image.asset('icons/blueDot.jpg', height: 8),
//                 SizedBox(
//                   width: 3,
//                 ),
//                 Text(
//                   'PMS',
//                   style: TextStyle(
//                     fontFamily: 'Mulish',
//                     fontWeight: FontWeight.w600,
//                     fontSize: 12,
//                     height: 1.33,
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(width: 50),
//                 Image.asset('icons/yellowDot.jpg', height: 8),
//                 SizedBox(
//                   width: 3,
//                 ),
//                 Text(
//                   'Fertile Window',
//                   style: TextStyle(
//                     fontFamily: 'Mulish',
//                     fontWeight: FontWeight.w600,
//                     fontSize: 12,
//                     height: 1.33,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding:
//                 const EdgeInsets.only(top: 19, bottom: 36, left: 19, right: 19),
//             child: Stack(children: [
//               Container(
//                 height: MediaQuery.of(context).size.height / 7,
//                 width: MediaQuery.of(context).size.width,
//                 margin: EdgeInsets.only(left: 0, top: 0),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color.fromRGBO(99, 89, 166, 0.07),
//                       blurRadius: 10,
//                       offset: Offset(0, 10),
//                     ),
//                     BoxShadow(
//                       color: Color.fromRGBO(99, 89, 166, 0.03),
//                       blurRadius: 12.9551,
//                       spreadRadius: 0,
//                       offset: Offset(0, 0),
//                     ),
//                   ],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                       padding: EdgeInsets.only(
//                         left: 18,
//                         top: 12,
//                       ),
//                       child: SvgPicture.asset('images/Icon.svg')),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(top: 18, left: 20, bottom: 16),
//                     child: Column(
//                       children: [
//                         Text('Has your period started?'),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(right: 15),
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 16, vertical: 6),
//                                 decoration: BoxDecoration(
//                                   color: Color(0xFFFCEEEB),
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: Text('Yes'),
//                               ),
//                             ),
//                             InkWell(
//                               onTap: _changeColor,
//                               child: Container(
//                                 // height:MediaQuery.of(context).size.height/20,
//                                 // width: MediaQuery.of(context).size.width/20,
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 10, vertical: 6),
//                                 decoration: BoxDecoration(
//                                   color: Color(0xFFFCEEEB),
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     print('No, ask me later');
//                                     customPrint('No, ask me later');
//                                   },
//                                   child: const Text('No, Ask me Later', style: TextStyle(color: _textColor?),),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ]),
//           )
//         ],
//       ),
//     );
//   }
// }
