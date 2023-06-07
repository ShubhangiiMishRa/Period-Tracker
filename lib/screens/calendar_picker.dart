import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:nexus/api/local_storage.dart';
import 'package:nexus/api/userdata.dart';
import 'package:nexus/home/testPage.dart';
import 'package:nexus/main.dart';
import 'package:nexus/util/colors.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../globalVariable.dart';
import 'history_page2.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  DateTime? firsDate;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
        // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    dateTimeList.clear();
    dateTimeListBlue.clear();

    int year = int.parse(prefs.getString(LocalStorage.userSelectedDay).toString().split("-")[0]);
    int month = int.parse(prefs.getString(LocalStorage.userSelectedDay).toString().split("-")[1]);
    int day = int.parse(prefs.getString(LocalStorage.userSelectedDay).toString().split("-")[2].split(" ")[0]);



    firsDate =  DateTime(year,month,day);
    // firsDate =  UserData.periodSelectedDay;

    for(int i = 0 ; i < UserData.flowDays.value; i++){
      customPrint("firsDate $i :: ${firsDate!.add(Duration(days: i))}");
      dateTimeList.add(firsDate!.add(Duration(days: i)));
    }
    for(int i = 1; i < 4; i++){
      customPrint("dateTimeListBlue $i :: ${firsDate!.add(Duration(days: i))}");
      dateTimeListBlue.add(firsDate!.subtract(Duration(days: i)));
    }

  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Color(0xFFF5F5F5),
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Color(0xFFF5F5F5),
              title: Text(
                'Calendar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1.33,
                  color: Color(0xFF0F2F5B),
                ),
              ),
            ),
            body: Stack(
              children: [
                Positioned(
                    left: 24,
                    right: 24,
                    top: 20,
                    height: 80,
                    child: Text(
                      'When did your cycle begin?',
                      style: TextStyle(
                        fontFamily: 'mulishbold',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        height: 1.23,
                        letterSpacing: 0.005,
                        color: const Color(0xFF0F2F5B),
                      ),
                    )),
                Obx(() {
                  return Positioned(
                    left: 24,
                    top: 80,
                    right: 24,
                    bottom: 0,
                    child: Column(children: [
                      SfDateRangePicker(
                        monthViewSettings: DateRangePickerMonthViewSettings(
                          blackoutDates: dateTimeListBlue,
                          specialDates: dateTimeList,
                        ),
                        monthCellStyle: DateRangePickerMonthCellStyle(
                          specialDatesDecoration: BoxDecoration(
                              color: colorCardRed,
                              // border: Border.all(color: const Color(
                              //     0xFF732B2B), width: 1),
                              shape: BoxShape.circle),
                          blackoutDatesDecoration: BoxDecoration(
                              color: colorCardBlue,
                              // border: Border.all(color: const Color(
                              //     0xFF732B2B), width: 1),
                              shape: BoxShape.circle),
                        ),
                        selectionTextStyle: const TextStyle(color: Colors.black),
                        rangeTextStyle: const TextStyle(color: Colors.white),
                        startRangeSelectionColor: Colors.white,
                        // selectionColor: colorDark,
                        endRangeSelectionColor: Colors.white,
                        rangeSelectionColor: Color(0xffF92A2A),
                        // onSelectionChanged: _onSelectionChanged,
                        view: DateRangePickerView.month,
                        initialSelectedRanges: [
                          PickerDateRange(
                              UserData.periodStartDate,
                              UserData.periodStartDate
                                  .add(Duration(days: UserData.flowDays.value))),
                        ],
                        // initialSelectedRanges: [],
                        selectionMode: DateRangePickerSelectionMode.range,
                        selectionRadius: 13,
                        selectionShape: DateRangePickerSelectionShape.circle,
                        // initialSelectedRange: PickerDateRange(
                        //     DateTime.now().subtract(const Duration(days: 4)),
                        //     DateTime.now().add(const Duration(days: 3))),
                      ),
                      Container(
                        height: 40.0,
                        width: 140,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white10.withOpacity(0.4),
                              spreadRadius: 4,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            )
                          ],
                          borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            nextPage(context, EditDates());
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              //backgroundColor: Colors.white,
                              shadowColor: Colors.transparent),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                'icons/Plus.svg',
                                height: 30,
                                width: 30,
                              ),
                              Text(
                                'Edit dates',
                                style: TextStyle(color: Color(0xffF92A2A)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  );
                }
                ),
              ],
            )));
  }
}
