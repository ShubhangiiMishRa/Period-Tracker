import 'dart:convert';
import 'dart:io';
import 'dart:io' as io;

import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:nexus/api/local_storage.dart';
import 'package:nexus/api/userdata.dart';
import 'package:nexus/globalVariable.dart';
import 'package:nexus/main.dart';
import 'package:nexus/screens/navigation.dart';
import 'package:nexus/screens/periods_log.dart';
import 'package:nexus/sql_api/historypage_api.dart';
import 'package:nexus/util/colors.dart';
import 'package:nexus/util/constants.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:syncfusion_flutter_previewer/pdfviewer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../models/history_page_model.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key, this.userName = "User"}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();

  final String userName;
}

class _HistoryPageState extends State<HistoryPage> {
  double pi = 3.1415926535897932;
  DateTime? pickedDate;
  DateTime pickedDateSelected = DateTime.now();
  List<Map<String, dynamic>> _icons = [];
  bool _isLoading = true;



  // double distance = (periodStartDate.day) * 1.0;
  // Range periodsRange = Range();
  // static int numberOfDaysInCycle = 28;
  // static int flowDays = 6;
  // DateTime periodStartDate = DateFormat('dd-MM-yyyy')
  //     .parse(prefs.getString(LocalStorage.userFirstDay) ?? "");
  int fertileWindowStart =
  (UserData.periodStartDate.day + UserData.flowDays.value + 5) > 0
      ? (UserData.periodStartDate.day)
      : (UserData.periodStartDate.day - 19);
  int fertileWindowEnd = (UserData.periodStartDate.day - 12) < 0
      ? (UserData.periodStartDate.day + 19)
      : (UserData.periodStartDate.day - 12);
  double _currentSliderValue = 30;
  int _selectedIndex = 0;

  // void _showIcons(int? index) async{
  //   if(index != null){
  //     final existingIcons = _icons.firstWhere((element) => element[index]==index);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    getHistoryData();
    setState(() {
      customPrint("start date :: ${UserData.periodStartDate}");
      customPrint("fertile window :: $fertileWindowStart to $fertileWindowEnd");
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        nextPage(context, const NavigatorPage());
        return Future.sync(() => false);
      },
      // onWillPop: () {
      //   AppExitPopup(context);
      //   return Future.value(false);
      // },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: const Color(0xFF0F2F5B),
            onPressed: () {
              nextPage(context, const NavigatorPage());
            },
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.calendar_month))
          ],
          title: const Text(
            'History',
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
        body: Obx(() {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              selectedColor: Colors.red,
                              unselectedColor: const Color(0xffDEDEDE),
                              // padding: pi/9,
                              padding: month(context, DateTime.now()) != 28
                                  ? (pi / 10)
                                  : (pi / 9),
                              width: 230,
                              height: 230,
                              startingAngle: 0,
                              arcSize: pi * 2,
                            ),
                            CircularStepProgressIndicator(
                              // totalSteps: 28,
                              totalSteps: month(context, DateTime.now()),
                              currentStep: 5,
                              stepSize: 10,
                              selectedColor: Colors.green,
                              unselectedColor: Colors.transparent,
                              padding: month(context, DateTime.now()) != 28
                                  ? (pi / 10)
                                  : (pi / 9),
                              // padding: pi / 10,
                              width: 230,
                              height: 230,
                              startingAngle:
                              0.2 * (UserData.flowDays.value + 5),
                              // startingAngle: pi/1.4,
                              // startingAngle:
                              //     month(context, DateTime.now()) == 30
                              //         ? (pi / 1.50)
                              //         : month(context, DateTime.now()) == 31
                              //             ? (pi / 1.55)
                              //             : pi / 1.4,
                              arcSize: 3.14 * 2,
                            ),
                            CircularStepProgressIndicator(
                              totalSteps: month(context, DateTime.now()),
                              currentStep: 3,
                              stepSize: 10,
                              selectedColor: Colors.blue,
                              unselectedColor: Colors.transparent,
                              padding: month(context, DateTime.now()) != 28
                                  ? (pi / 10)
                                  : (pi / 9),
                              width: 230,
                              height: 230,
                              startingAngle:
                              month(context, DateTime.now()) != 28
                                  ? (pi / 2 * 3.6)
                                  : (pi / 2 * 3.14),
                              arcSize: 3.14 * 2,
                              child: Center(
                                child: Container(
                                  width: 180,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Transform.rotate(
                                    angle:
                                    -(2 * pi / 30) * UserData.prevDate!.day,
                                    child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Last Month',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xff0F2F5B)),
                                            ),
                                            Text(
                                                '${UserData.prevDate.day} ${DateFormat('MMMM').format(UserData.prevDate)}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff0F2F5B))),
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
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 20, bottom: 10),
                  //   child: Center(
                  //     child:
                  //     Stack(
                  //       children: [
                  //         CircularStepProgressIndicator(
                  //           totalSteps: 30,
                  //           currentStep: 6,
                  //           stepSize: 10,
                  //           selectedColor: Colors.red,
                  //           unselectedColor: Color(0xffDEDEDE),
                  //           padding: 3.14 / 10,
                  //           width: 230,
                  //           height: 230,
                  //           startingAngle: 0,
                  //           arcSize: 3.14 * 2,
                  //           child: Center(
                  //             child: Container(
                  //               width: 180,
                  //               height: 180,
                  //               decoration: BoxDecoration(
                  //                 color: Colors.white,
                  //                 borderRadius: BorderRadius.circular(100),
                  //               ),
                  //               child: Center(
                  //                   child: Column(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Text(
                  //                     'Last Month',
                  //                     style: TextStyle(
                  //                         fontSize: 14,
                  //                         fontWeight: FontWeight.w600,
                  //                         color: Color(0xff0F2F5B)),
                  //                   ),
                  //                   Text(
                  //                       "${UserData.prevDate.day} ${DateFormat('MMMM').format(UserData.prevDate)}",
                  //                       style: TextStyle(
                  //                           fontSize: 18,
                  //                           fontWeight: FontWeight.w600,
                  //                           color: Color(0xff0F2F5B))),
                  //                 ],
                  //               )),
                  //             ),
                  //           ),
                  //         ),
                  //         CircularStepProgressIndicator(
                  //           totalSteps: 30,
                  //           currentStep: 7,
                  //           stepSize: 10,
                  //           selectedColor: Colors.green,
                  //           unselectedColor: Colors.transparent,
                  //           padding: 3.14 / 10,
                  //           width: 230,
                  //           height: 230,
                  //           startingAngle: pi / 1.65,
                  //           arcSize: 3.14 * 2,
                  //           // child: Center(
                  //           //   child: Container(
                  //           //     width: MediaQuery.of(context).size.width / 2,
                  //           //     height: MediaQuery.of(context).size.width / 2,
                  //           //     margin: EdgeInsets.all(40),
                  //           //     decoration: BoxDecoration(
                  //           //       color: Colors.white,
                  //           //       boxShadow: [
                  //           //         BoxShadow(
                  //           //           color: Color.fromRGBO(249, 42, 42, 0.25),
                  //           //           blurRadius: 50.8157,
                  //           //           spreadRadius: 0,
                  //           //           offset: Offset(0, 0),
                  //           //         ),
                  //           //       ],
                  //           //       borderRadius: BorderRadius.circular(150),
                  //           //     ),
                  //           //     child: Center(
                  //           //         child: Column(
                  //           //           mainAxisAlignment: MainAxisAlignment.center,
                  //           //           children: [
                  //           //             Text(
                  //           //               'Last Month',
                  //           //               style: TextStyle(
                  //           //                   fontSize: 12,
                  //           //                   fontWeight: FontWeight.w600,
                  //           //                   color: Color(0xff0F2F5B)),
                  //           //             ),
                  //           //             Text('28 November',
                  //           //                 style: TextStyle(
                  //           //                     fontSize: 16,
                  //           //                     fontWeight: FontWeight.w600,
                  //           //                     color: Color(0xff0F2F5B))),
                  //           //           ],
                  //           //         )),
                  //           //   ),
                  //           // ),
                  //         ),
                  //         CircularStepProgressIndicator(
                  //           totalSteps: 30,
                  //           currentStep: 3,
                  //           stepSize: 10,
                  //           selectedColor: Colors.blue,
                  //           unselectedColor: Colors.transparent,
                  //           padding: 3.14 / 10,
                  //           width: 230,
                  //           height: 230,
                  //           startingAngle: pi / 2 * 3.46,
                  //           arcSize: 3.14 * 2,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  const Text(
                    'Period History',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 26,
                      height: 1.33,
                      color: Color(0xFF0F2F5B),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Current Cycle',
                                style: TextStyle(
                                  fontFamily: 'Mulish',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  height: 1.33,
                                  color: Color(0xFF0F2F5B),
                                ),
                              ),

                              InkWell(onTap: () async {



                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content:  Container(
                                          height: 400,
                                          child: SfDateRangePicker(
                                            view: DateRangePickerView.year,
                                            selectionTextStyle: const TextStyle(color: Colors.black),
                                            rangeTextStyle: const TextStyle(color: Colors.white),
                                            startRangeSelectionColor: Colors.white,
                                            endRangeSelectionColor: Colors.white,
                                            selectionColor: colorError,
                                            showActionButtons: true,
                                            onSubmit: (value) async {
                                              customPrint("select date is here ::: $value");
                                              pickedDateSelected = value as DateTime;
                                              getHistoryData();
                                              Navigator.pop(context);
                                            },
                                            onCancel: () {
                                              Navigator.pop(context);
                                            },
                                            rangeSelectionColor: colorCardRed,
                                            selectionMode: DateRangePickerSelectionMode.single,
                                            selectionRadius: 13,
                                            selectionShape: DateRangePickerSelectionShape.circle,
                                            initialSelectedRange: PickerDateRange(
                                                DateTime.now().subtract(const Duration(days: 4)),
                                                DateTime.now().add(const Duration(days: 3))),
                                          ),
                                        ),
                                      );
                                    }
                                );
                                //
                                // pickedDate = await showDatePicker(
                                //     context: context,
                                //     initialDate: DateTime.now(),
                                //     firstDate: DateTime(1950),
                                //
                                //     //DateTime.now() - not to allow to choose before today.
                                //     lastDate: DateTime(2100));
                                //
                                // if (pickedDate != null) {
                                //   print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                //   String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate!);
                                //   print(formattedDate);
                                //   pickedDateSelected = pickedDate;//formatted date output using intl package =>  2021-03-16
                                //   getHistoryData();
                                //   setState(() {
                                //     // dateTwo.text = formattedDate; //set output date to TextField value.//set output date to TextField value.
                                //   });
                                // } else {}
                              },child: Icon(Icons.calendar_month,color:   Color(0xffdc3d83) )),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 28),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // StepProgressIndicator(
                                //   // roundedEdges: Radius.circular(1),
                                //   // currentStep: 0,
                                //   totalSteps: (DateTime.now().month == 1 ||
                                //           DateTime.now().month == 3 ||
                                //           DateTime.now().month == 5 ||
                                //           DateTime.now().month == 7 ||
                                //           DateTime.now().month == 8 ||
                                //           DateTime.now().month == 10 ||
                                //           DateTime.now().month == 12)
                                //       ? 31
                                //       : (DateTime.now().month == 4 ||
                                //               DateTime.now().month == 6 ||
                                //               DateTime.now().month == 9 ||
                                //               DateTime.now().month == 11)
                                //           ? 30
                                //           : 28,
                                //   padding: 0,
                                //   size: 6,
                                //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   customColor: (index) => (index >= UserData.periodStartDate.day - 1 &&
                                //           index <= UserData.periodStartDate.day + UserData.flowDays.value - 1)
                                //       ? Colors.redAccent
                                //       : (index >= fertileWindowStart - 1 && index <= fertileWindowEnd - 1)
                                //           ? Colors.green
                                //           : (index < (UserData.periodStartDate.day - 1) &&
                                //                   index > UserData.periodStartDate.day - 5)
                                //               ? Colors.blue
                                //               : Color(0xffDEDEDE),
                                // ),
                                StepProgressIndicator(
                                  // roundedEdges: Radius.circular(1),
                                  // currentStep: 0,
                                  totalSteps: (selectedDate.month == 1 ||
                                      selectedDate.month == 3 ||
                                      selectedDate.month == 5 ||
                                      selectedDate.month == 7 ||
                                      selectedDate.month == 8 ||
                                      selectedDate.month == 10 ||
                                      selectedDate.month == 12)
                                      ? 31
                                      : (selectedDate.month == 4 ||
                                      selectedDate.month == 6 ||
                                      selectedDate.month == 9 ||
                                      selectedDate.month == 11)
                                      ? 30
                                      : 28,
                                  padding: 0,
                                  size: 6,
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  customColor: (index) => (index >=
                                      UserData.periodStartDate.day &&
                                      index <=
                                          UserData.periodStartDate.day +
                                              UserData.flowDays.value)
                                      ? Colors.redAccent
                                      : (index >=
                                      UserData.periodStartDate.day +
                                          UserData.flowDays.value +
                                          5 &&
                                      index <=
                                          UserData.periodStartDate.day +
                                              UserData.flowDays.value +
                                              10)
                                      ? Colors.green
                                      : (index <
                                      (UserData.periodStartDate
                                          .day) &&
                                      index >
                                          UserData.periodStartDate
                                              .day -
                                              3)
                                      ? Colors.blue
                                      : const Color(0xffDEDEDE),
                                ),
                                if (showCircle())
                                  Row(
                                    children: [
                                      SizedBox(width: getCirclePosition()),
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          const Icon(
                                            Icons.circle,
                                            color: Colors.redAccent,
                                            size: 22,
                                          ),
                                          Text(
                                            UserData.periodStartDate.day
                                                .toString(),
                                            // DateTime.now().day.toString(),
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text(
                              'Period Logs',
                              style: TextStyle(
                                fontFamily: 'Mulish',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                height: 1.33,
                                color: Color(0xFF0F2F5B),
                              ),
                            ),
                          ),
                          HistoryPageApi.savedHistoryDataModel.value.isNotEmpty      ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: HistoryPageApi
                                .savedHistoryDataModel.value.length,
                            itemBuilder: (BuildContext context, int index) {
                              final data = HistoryPageApi
                                  .savedHistoryDataModel.value[index];
                              customPrint(
                                  "savedHistoryDataModel :: ${data.length}");
                              // List of perticular date;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.circle,
                                            size: 8,
                                            color: Color(0xff6359A6),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            data[index].date,
                                            // getHistoryData().toString(),
                                            // HistoryPageApi.historyPageModel[index].date.toString(),
                                            style: const TextStyle(
                                                color: Color(0xff0F2F5B),
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // HistoryPageApi.deleteAllItem();
                                          customPrint("${data[index].date}");
                                          customPrint(
                                              "${data[index].date.split("-")[0]}");
                                          customPrint(
                                              "${data[index].date.split("-")[1]}");
                                          customPrint(
                                              data[index].date.split("-")[2]);
                                          //2023-05-18 05:29:00.000
                                          DateTime dateTime = DateTime(
                                              int.parse(data[index]
                                                  .date
                                                  .split("-")[2]),
                                              int.parse(data[index]
                                                  .date
                                                  .split("-")[1]),
                                              int.parse(data[index]
                                                  .date
                                                  .split("-")[0]));
                                          // DateTime dateTime = DateTime.parse("${data[index].date.split("-")[2]}-${data[index].date.split("-")[1]}-${data[index].date.split("-")[0]}");
                                          // String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
                                          // print(formattedDate);

                                          customPrint(
                                              "formattedDate dateTime :: ${dateTime}");
                                          nextPage(
                                              context,
                                              PeriodsLog(
                                                selectDateForPeriodsLogs:
                                                dateTime,
                                              ));
                                        },
                                        child: Row(
                                          children: [
                                            const Icon(Icons.edit_rounded,
                                                size: 17,
                                                color: Color(0xff777777)),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            const Text(
                                              'Edit',
                                              style: TextStyle(
                                                  color: Color(0xff777777)),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Wrap(
                                    children:
                                    List.generate(data.length, (index) {
                                      final dataOfDate = data[index];
                                      customPrint(
                                          "data.length  ::: ${data.length}");
                                      customPrint(
                                          "data.HistoryPageApi.savedHistoryDataModel.value.length  ::: ${HistoryPageApi.savedHistoryDataModel.value.length}");
                                      return Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          children: [
                                            SvgPicture.asset(
                                                dataOfDate.imagePath),
                                            Text(dataOfDate.title,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 12))
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                              );
                            },
                          ) : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Save your first period log",
                                style: TextStyle(
                                  fontFamily: 'mulishbold',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 16,
                                  height: 1.14,
                                  // equivalent to line-height: 15px
                                  // letterSpacing: -0.480392,
                                  color: colorBlack,
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  nextPage(context, PeriodsLog(selectDateForPeriodsLogs: selectedDate));
                                },
                                child: Text(
                                  " Here",
                                  style: TextStyle(
                                    fontFamily: 'mulishbold',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    height: 1.14,
                                    // equivalent to line-height: 15px
                                    // letterSpacing: -0.480392,
                                    color: colorCardRed,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          ///
                          // Obx(() {
                          //   return ListView.builder(
                          //     shrinkWrap: true,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     itemCount:
                          //         HistoryPageApi.savedHistoryDataModel.length,
                          //     itemBuilder: (BuildContext context, int index) {
                          //       final data =
                          //           HistoryPageApi.savedHistoryDataModel.value[index];
                          //       customPrint(
                          //           "savedHistoryDataModel :: ${data.length}");
                          //       // List of perticular date;
                          //       return Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           Row(
                          //             children: [
                          //               Icon(
                          //                 Icons.circle,
                          //                 size: 8,
                          //                 color: Color(0xff6359A6),
                          //               ),
                          //               SizedBox(width: 8),
                          //               Text(
                          //                 data[index].date,
                          //                 // getHistoryData().toString(),
                          //                 // HistoryPageApi.historyPageModel[index].date.toString(),
                          //                 style: TextStyle(
                          //                     color: Color(0xff0F2F5B),
                          //                     fontSize: 12),
                          //               )
                          //             ],
                          //           ),
                          //           SizedBox(
                          //             height: 8,
                          //           ),
                          //           Wrap(
                          //             children:
                          //                 List.generate(data.length, (index) {
                          //               final dataOfDate = data[index];
                          //               return Padding(
                          //                 padding: const EdgeInsets.all(12),
                          //                 child: Column(
                          //                   children: [
                          //                     SvgPicture.asset(
                          //                         dataOfDate.imagePath),
                          //                     Text(dataOfDate.title,
                          //                         textAlign: TextAlign.center,
                          //                         style:
                          //                             TextStyle(fontSize: 12))
                          //                   ],
                          //                 ),
                          //               );
                          //             }),
                          //           ),
                          //           SizedBox(
                          //             height: 8,
                          //           ),
                          //         ],
                          //       );
                          //     },
                          //   );
                          // }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Container(
                    height: 44.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          ),
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          ),
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xffdc3d83), Color(0xffac4dba)])),
                    child: ElevatedButton(
                      onPressed: () {
                        // getHistoryData();
                        // nextPage(context, PdfPage());
                        // requestPermissions();
                        // createTestPdf();

                        if(HistoryPageApi.savedHistoryDataModel.value.isNotEmpty){
                          createTestPdf();
                        }else{
                          showSnackbar(context, "No period history is saved", colorError);
                        }

                        // createPDF();
                        // savePDF();
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent),
                      child: const Text('Download Period History'),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

//   Future<void> getHistoryData() async {
//     // Create a new PDF document.
//     final PdfDocument document = PdfDocument();
// // Add a PDF page and draw text.
//     document.pages.add().graphics.drawString(
//         'Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 12),
//         brush: PdfSolidBrush(PdfColor(0, 0, 0)),
//         bounds: const Rect.fromLTWH(0, 0, 150, 20));
// // Save the document.
//     File('HelloWorld.pdf').writeAsBytes(await document.save());
// // Dispose the document.
//     document.dispose();
//   }
// }

  Future<void> getHistoryData() async {
    // final date = prefs.getString(LocalStorage.userFirstDay)!;
    // customPrint("getHistoryData Date :: $date");
    // String date = "30-4-2023";
    // DateTime dateTime = DateFormat("dd-MM-yyyy").parse(prefs.getString(LocalStorage.userFirstDay)!);
    customPrint("getHistoryData selectedDate :: $pickedDateSelected");
    DateTime dateTimeConvert = DateFormat("dd-MM-yyyy").parse(
        "${pickedDateSelected!.day}-${pickedDateSelected!.month}-${pickedDateSelected!.year}");
    int cycle =
    int.parse(prefs.getString(LocalStorage.userFlowDuration) ?? "0");
    String date =
        "${dateTimeConvert.day}-${dateTimeConvert.month}-${dateTimeConvert.year}";
    customPrint("getHistoryData cycle :: $cycle");

    customPrint("getHistoryData date :: $date");
    customPrint(
        "getHistoryData dateTime :: ${dateTimeConvert.toString().split(" ")[0]}");
    customPrint("getHistoryData dateTime :: ${dateTimeConvert}");

    HistoryPageApi.savedHistoryDataModel.value.clear();

    final year = dateTimeConvert.year;
    final monthOfSelectTime = dateTimeConvert.month;

    final firstDayOfMonth = DateTime(year, monthOfSelectTime, 1);
    final lastDayOfMonth = DateTime(year, monthOfSelectTime + 1, 0);

    for (var day = firstDayOfMonth;
    day.isBefore(lastDayOfMonth.add(const Duration(days: 1)));
    day = day.add(const Duration(days: 1))) {
      customPrint(
          "====================================================================");
      // customPrint("month date = ${day.day}-${day.month}-${day.year}");

      // }
      //
      // for (int i = 0; i < month(context, DateTime.now()); i++) {
      //   dateTimeConvert = dateTimeConvert.add(Duration(days: i));
      // dateTime = dateTime.adddateTimeConvert(Duration(days: i));
      final date = "${day.day}-${day.month}-${day.year}";
      customPrint("getItemByDateTime loop Date  :: $date");
      customPrint("getItemByDateTime loop selectedDate :: $pickedDateSelected");
      final dataByDate =
      await HistoryPageApi.getItemByDateTime(date.toString());
      // final data = await HistoryPageApi.getItemByDateTime(UserData.periodStartDate.add(Duration(days: i)).toString());
      final singleData = historyPageModelFromJson(jsonEncode(dataByDate));
      // HistoryPageApi.savedHistoryDataModel.add(singleData);
      // customPrint("getHistoryData 2 $i :: ${dataByDate}");
      // customPrint("getHistoryData 3 $i :: ${singleData}");
      // customPrint("getHistoryData 4 $i :: ${singleData.isEmpty ? true : false}");
      if (singleData.isNotEmpty) {
        HistoryPageApi.savedHistoryDataModel.value.add(singleData);
        // customPrint(
        //     "getHistoryData loop data by date :: ${jsonEncode(dataByDate)}");
        setState(() {});
      }
      setState(() {});
      customPrint(
          "====================================================================");
    }
  }

  Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
  }

  Future<void> createPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Hello World!'),
        ),
      ),
    );

    final Directory directory = await getTemporaryDirectory();
    final String filePath = '${directory.path}/periodHistory.pdf';
    final File file = File(filePath);

    await file.writeAsBytes(await pdf.save());
    // final String path = '${directory.path}/example.pdf';
    // final file = File(path);
    // await file.writeAsBytes(await pdf.save());
    // final file = File('example.pdf');
    // await file.writeAsBytes(await pdf.save());
    // final output = await getTemporaryDirectory();
    // final path = "${output.path}/temp.pdf";
    // final file = await io.File(path).writeAsBytes(await pdf.save());
    print('PDF file saved at: $filePath');
    customPrint("file :: ${file.path}");
    OpenFile.open(file.path);
  }

  final pdf = pw.Document();

// Future<File> _getFile() async {
//   final directory = await getApplicationDocumentsDirectory();
//   final file = File("${directory.path}/data.json");
//
//   final doesExist = await file.exists();
//
//   if(!doseExist) {
//     file = await file.create();
//   }
//   return file;
// }
  void createPDF() async {
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context contex) {
          return pw.Center(child: pw.Text("Pdf created successfully..."));
        }));
  }

  void savePDF() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file =
      File('android/data/${DateTime.now().millisecondsSinceEpoch}.pdf');
      await file.writeAsBytes(await pdf.save());
      showSnackbar(context, 'Success', const Color(0xff000000));
      print(dir.path);
      //showPrintedMessage('success','saved to documets');
    } catch (e) {
      showSnackbar(context, 'Error', const Color(0xffff0000));
    }
  }

  void _sharePdf(BuildContext context) async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text('PDF content'),
        );
      },
    ));
    final directory = await DownloadsPathProvider.downloadsDirectory;
    final file = File('${directory?.path}/example.pdf');
    await file.writeAsBytes(await pdf.save());

    Share.shareFiles([file.path]);
  }

  // Future<pw.Document> buildPdf() async {
  //   final pdf = pw.Document();
  //   final data = HistoryPageApi.getItems();
  //   pdf.addPage(
  //     pw.Page(
  //       build: (pw.Context context) {
  //         return pw.Center(
  //           child: pw.Column(
  //             mainAxisAlignment: pw.MainAxisAlignment.center,
  //             children: [
  //               for (final item in data)
  //                 pw.Text(item['your_column_name'].toString()),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  //   return pdf;
  // }

  createTestPdf() async {
    // Future<void> svgStrings = getHistoryData();
    if (true) {
      List<Map<String, dynamic>> images = [];
      for (int i = 0; i < HistoryPageApi.savedHistoryDataModel.length; i++) {
        final data = HistoryPageApi.savedHistoryDataModel[i];
        final date = data[i].date;
        images = await HistoryPageApi.getItemByDateTime(date);
      }
      final svgWidgets = [];
      for (Map<String, dynamic> image in images) {
        // final svgData = image['svgData'];
        // final svgPicture = SvgPicture.string(svgData);
        // final pictureRecorder = ui.PictureRecorder();
        // final canvas = Canvas(pictureRecorder);
        // final svgPictureDrawable = svgPicture.createDrawable();
        // svgPictureDrawable.draw(canvas);
        // final picture = pictureRecorder.endRecording();
        // final img = await picture.toImage(100, 100);
        // final pngBytes = (await img.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
        // final imageWidget = pw.Image(pw.MemoryImage(pngBytes));
        // svgWidgets.add(imageWidget);
      }
      // if (await Permission.storage.request().isGranted) {
      final pdf = pw.Document();
      // final data = await getHistoryData();
      // final svgImage = pw.SvgImage(svg: dataOfDate.imagePath);
      // customPrint("PDF before savedHistoryDataModel :: ${HistoryPageApi.savedHistoryDataModel.value[0].length}");
      customPrint(
          "PDF before savedHistoryDataModel :: ${HistoryPageApi.savedHistoryDataModel.value.length}");
      pdf.addPage(
        pw.Page(
          // theme: myTheme,
          build: (pw.Context context) => pw.Padding(
              padding: const pw.EdgeInsets.all(12),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Text(prefs.getString(LocalStorage.userName) ?? "",style: pw.TextStyle(fontSize: 26,    fontStyle: pw.FontStyle.normal,
                    fontWeight: pw.FontWeight.bold,)),
                  pw.Text("Monthly Period History ${DateFormat('MMM').format(DateTime(selectedDate.year,selectedDate.month,selectedDate.day))}",style: pw.TextStyle(fontSize: 18,color: PdfColor.fromHex("8D8D8D"))),
                  pw.SizedBox(height: constants.defaultPadding/2),

                  pw.Column(
                      children: List.generate(
                          HistoryPageApi.savedHistoryDataModel.value.length,
                              (columnIndex) {
                            final data =
                            HistoryPageApi.savedHistoryDataModel.value[columnIndex];
                            customPrint("PDF savedHistoryDataModel :: ${data.length}");
                            return pw.Container(
                              margin: const pw.EdgeInsets.symmetric(vertical: 8),
                              padding: const pw.EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: pw.BoxDecoration(

                                // border: pw.Border.all(
                                //     width: 1, color: PdfColor.fromHex("DEDEDE")),
                                  color: PdfColor.fromHex("F5F5F5")),
                              // color:  PdfColor.fromHex("0xffF5F5F5"),
                              child: pw.Padding(
                                padding: const pw.EdgeInsets.only( right: 5),
                                child: pw.Row(
                                  children: [
                                    pw.Padding(
                                      padding: const pw.EdgeInsets.all(10.0),
                                      child: pw.Container(
                                        decoration: pw.BoxDecoration(
                                          borderRadius:  pw.BorderRadius.all(
                                              pw.Radius.circular(constants.radius)),
                                          color: PdfColor.fromHex("ffffff"),
                                          // border: pw.Border.all(
                                          //     width: 1,
                                          //     color: PdfColor.fromHex("000000")),
                                        ),
                                        child: pw.Padding(
                                          padding: const pw.EdgeInsets.all(10.0),
                                          child: pw.Column(
                                            children: [
                                              pw.Text(
                                                '${data[columnIndex].date.split("-")[0]}',
                                                style: const pw.TextStyle(fontSize: 16),
                                              ),
                                              pw.Text('${DateFormat('MMM').format(DateTime(int.parse(data[columnIndex].date.split("-")[2]),int.parse(data[columnIndex].date.split("-")[1]),int.parse(data[columnIndex].date.split("-")[0])))} ${data[columnIndex].date.split("-")[2]}',
                                                  style:
                                                  const pw.TextStyle(fontSize: 8))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    pw.Expanded(
                                      child: pw.Wrap(
                                          spacing: 16,
                                          runSpacing: 10,
                                          direction: pw.Axis.horizontal,
                                          children:
                                          List.generate(data.length, (rowIndex) {
                                            final dataOfDate = data[rowIndex];
                                            customPrint(
                                                "PDF data.length  ::: ${data.length}");
                                            customPrint(
                                                "PDF dataOfDate.title ::: ${dataOfDate.title}");
                                            customPrint(
                                                "PDF data.HistoryPageApi.savedHistoryDataModel.value.length  ::: ${HistoryPageApi.savedHistoryDataModel.value.length}");

                                            // final svgPath = 'path/to/your/svg_file.svg';
                                            //
                                            // // Load the SVG file
                                            // final svgData = File(svgPath).readAsStringSync();
                                            return pw.Column(
                                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                                              mainAxisAlignment: pw.MainAxisAlignment.center,
                                              children: [

                                                // pw.Image(pw.ImageImage(imageA)),
                                                // pw.Image(PdfImagePage.fromUri(img.uri, PagePosition.center)),
                                                pw.SvgImage(
                                                    svg: dataOfDate.imagePathSvg),
                                                pw.SizedBox(height: constants.defaultPadding/2),
                                                // pw.SvgImage(svg: dataOfDate.imagePath ),
                                                // SvgPicture.asset('images/Mediumf.svg'),
                                                pw.Text(
                                                  '${dataOfDate.title}',
                                                  style: pw.TextStyle(
                                                      color: PdfColor.fromHex("000000"),
                                                      fontSize: 10),
                                                  textAlign: pw.TextAlign.center,
                                                ),
                                              ],
                                            );
                                          })),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }))
                ],
              )),
          // build: (pw.Context context) => pw.Center(
          //   child: pw.ListView(children: [
          //     pw.Column(
          //       crossAxisAlignment: pw.CrossAxisAlignment.start,
          //       children: [
          //         pw.Text(
          //           prefs.getString(LocalStorage.userName) ?? "",
          //           style: pw.TextStyle(
          //               fontWeight: pw.FontWeight.bold, fontSize: 22),
          //         ),
          //         pw.SizedBox(
          //           height: 6,
          //         ),
          //         pw.Text(
          //           'Monthly Period History',
          //           style: pw.TextStyle(
          //               fontWeight: pw.FontWeight.bold, fontSize: 14),
          //         ),
          //         pw.SizedBox(
          //           height: 18,
          //         ),
          //         pw.Padding(
          //           padding: pw.EdgeInsets.only(top: 10, right: 5),
          //           child: pw.Row(
          //             children: [
          //               pw.Padding(
          //                 padding: const pw.EdgeInsets.all(10.0),
          //                 child: pw.Padding(
          //                   padding: const pw.EdgeInsets.all(10.0),
          //                   child: pw.Column(
          //                       // children: [Text('01', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),), Text('Nov 2023', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 8))],
          //                       ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //         pw.ListView.builder(
          //           itemCount: HistoryPageApi.savedHistoryDataModel.length,
          //           itemBuilder: (pw.Context context, int index) {
          //             final data = HistoryPageApi.savedHistoryDataModel[index];
          //             // List of perticular date;
          //             return pw.Column(
          //               crossAxisAlignment: pw.CrossAxisAlignment.start,
          //               children: [
          //                 pw.Row(
          //                   children: [
          //                     pw.SizedBox(width: 8),
          //                     pw.Text(
          //                       data[index].date,
          //                       // getHistoryData().toString(),
          //                       // HistoryPageApi.historyPageModel[index].date.toString(),
          //                       style: pw.TextStyle(fontSize: 12),
          //                     )
          //                   ],
          //                 ),
          //                 pw.SizedBox(
          //                   height: 8,
          //                 ),
          //                 pw.Wrap(
          //                   children: List.generate(data.length, (index) {
          //                     final dataOfDate = data[index];
          //                     return pw.Padding(
          //                       padding: pw.EdgeInsets.all(12),
          //                       child: pw.Column(
          //                         children: [
          //                           // pw.SvgImage(
          //                           //   svg: dataOfDate.imagePath,
          //                           //   width: 100,
          //                           //   height: 100,
          //                           // ),
          //                           pw.Text(
          //                             dataOfDate.title,
          //                             textAlign: pw.TextAlign.center,
          //                             style: pw.TextStyle(fontSize: 12),
          //                           ),
          //                         ],
          //                       ),
          //                     );
          //                   }),
          //                 ),
          //                 // pw.GridView(
          //                 //   crossAxisCount: 5,
          //                 //   children: List.generate(data.length, (index) {
          //                 //     final dataOfDate = data[index];
          //                 //     return pw.Padding(
          //                 //       padding: const pw.EdgeInsets.all(12),
          //                 //       child: pw.Column(
          //                 //         children: [
          //                 //           pw.SvgImage(svg: dataOfDate.imagePath),
          //                 //           pw.Text(dataOfDate.title,
          //                 //               textAlign: pw.TextAlign.center,
          //                 //               style: pw.TextStyle(fontSize: 12))
          //                 //         ],
          //                 //       ),
          //                 //     );
          //                 //   }),
          //                 // ),
          //                 pw.SizedBox(
          //                   height: 8,
          //                 ),
          //               ],
          //             );
          //           },
          //         )
          //       ],
          //     )
          //   ]),
          // ),
        ),
      );
      // Share.shareFiles([pdf], text: 'Reports');
      //replace your code to save file from bellow
      // final output = await getApplicationDocumentsDirectory();
      final output = (await getExternalStorageDirectory())!;
      if (!await output.exists()) {
        await output.create(recursive: true);
      }
      final path =
          "${output.path}/${DateTime.now().millisecondsSinceEpoch}.pdf";
      final file = await io.File(path).writeAsBytes(await pdf.save());
      customPrint("file :: ${file.path}");
      customPrint("File exists :: ${await file.exists()}");
      OpenFile.open(file.path);
    }
  }

  //GET HISTORY OF DATA FOR MONTH

  double getCirclePosition() {
    double maxPosition = MediaQuery.of(context).size.width - 70;
    double minPosition = 0;

    double difference = maxPosition - minPosition;
    customPrint("difference :: $difference");
    int division = (difference / 30).round();
    customPrint("division :: $division");
    int durationCycle =
    int.parse(prefs.getString(LocalStorage.userFlowDuration) ?? "0");
    DateTime endDate =
    UserData.periodStartDate.add(Duration(days: durationCycle));
    // int diffDays = periodStartDate.difference(endDate).inDays;
    // int todayDay = DateTime.now().day;
    // int todayDay = selectedDate.day;
    int todayDay = UserData.periodStartDate.day;
    if (todayDay > 29) {
      todayDay = 29;
    }
    double value = (todayDay.toDouble() * division);
    return value;
  }

  bool showCircle() {
    int durationCycle =
    int.parse(prefs.getString(LocalStorage.userFlowDuration) ?? "0");
    DateTime endDate =
    UserData.periodStartDate.add(Duration(days: durationCycle));
    if ((DateTime.now().isAfter(UserData.periodStartDate) ||
        DateTime.now().isAtSameMomentAs(UserData.periodStartDate)) &&
        (DateTime.now().isBefore(endDate) ||
            DateTime.now().isAtSameMomentAs(endDate))) {
      return true;
    }
    // return false;
    return true;
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
