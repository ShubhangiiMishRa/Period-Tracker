// import 'dart:html';
import 'dart:convert';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nexus/Widgets/progressHud.dart';
import 'package:nexus/api/userdata.dart';
import 'package:nexus/screens/navigation.dart';
import 'package:nexus/screens/periods_log.dart';
import 'package:nexus/sql_api/historypage_api.dart';
import 'package:nexus/util/colors.dart';
import 'package:nexus/util/constants.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../api/local_storage.dart';
import '../globalVariable.dart';
import '../main.dart';
import '../models/history_page_model.dart';

class EditDates extends StatefulWidget {
  const EditDates({Key? key}) : super(key: key);

  @override
  State<EditDates> createState() => _EditDatesState();
}

class _EditDatesState extends State<EditDates> {
  double distance = (periodStartDate.day) * 1.0;

  // Range periodsRange = Range();
  static int numberOfDaysInCycle = 28;
  static int flowDays = 6;
  static DateTime periodStartDate = DateTime.now();
  int fertileWindowStart = periodStartDate.day - 19;
  int fertileWindowEnd = periodStartDate.day - 12;
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHistoryData();
    setState(() {
      customPrint("start date 2 :: ${UserData.periodStartDate}");
      customPrint(
          "fertile window 2 :: $fertileWindowStart to $fertileWindowEnd");
    });
  }

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

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFF5F5F5),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF0F2F5B)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'History',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Mulish bold',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            height: 1.33,
            color: Color(0xFF0F2F5B),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ProgressHUD(
          isLoading: isLoading,
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              SfDateRangePicker(
                view: DateRangePickerView.year,
                selectionTextStyle: const TextStyle(color: Colors.black),
                rangeTextStyle: const TextStyle(color: Colors.white),
                startRangeSelectionColor: Colors.white,
                endRangeSelectionColor: Colors.white,
                selectionColor: colorError,
                showActionButtons: true,
                onSubmit: (value) async {
                  customPrint("select date is here ::: $value");

                  DateTime newValue = DateTime(
                      int.parse(value.toString().split("-")[0]),
                      int.parse(value.toString().split("-")[1]),
                      int.parse(value.toString().split("-")[2].split(" ")[0]));
                  // UserData.periodSelectedDay = value;
                  dateTimeList.clear();
                  dateTimeListBlue.clear();
                  customPrint(
                      "select date is here year ::: ${int.parse(value.toString().split("-")[0])}");
                  customPrint(
                      "select date is here month ::: ${int.parse(value.toString().split("-")[1])}");
                  customPrint(
                      "select date is here day ::: ${int.parse(value.toString().split("-")[2].split(" ")[0])}");
                  customPrint("select date is here newValue ::: $newValue");
                  await prefs.setString(
                      LocalStorage.userSelectedDay, newValue.toString());
                  customPrint(
                      "select date is here newValue 1 ::: ${prefs.getString(LocalStorage.userSelectedDay)}");

                  int year = int.parse(prefs
                      .getString(LocalStorage.userSelectedDay)
                      .toString()
                      .split("-")[0]);
                  int month = int.parse(prefs
                      .getString(LocalStorage.userSelectedDay)
                      .toString()
                      .split("-")[1]);
                  int day = int.parse(prefs
                      .getString(LocalStorage.userSelectedDay)
                      .toString()
                      .split("-")[2]
                      .split(" ")[0]);

                  UserData.periodSelectedDay = DateTime(year, month, day);
                  DateTime selectB = DateTime(year, month, day);

                  for (int i = 0; i < UserData.flowDays.value; i++) {
                    customPrint(
                        "firsDate $i :: ${selectB!.add(Duration(days: i))}");
                    dateTimeList.add(selectB!.add(Duration(days: i)));
                  }
                  for (int i = 1; i < 4; i++) {
                    customPrint(
                        "dateTimeListBlue $i :: ${selectB!.add(Duration(days: i))}");
                    dateTimeListBlue.add(selectB!.subtract(Duration(days: i)));
                  }

                  setState(() {});
                  nextPage(
                      context,
                      NavigatorPage(
                        index: 2,
                      ));
                  // Navigator.pop(context);
                },
                onCancel: () {
                  Navigator.pop(context);
                },
                rangeSelectionColor: colorCardRed,
                onSelectionChanged: _onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.single,
                selectionRadius: 13,
                selectionShape: DateRangePickerSelectionShape.circle,
                initialSelectedRange: PickerDateRange(
                    DateTime.now().subtract(const Duration(days: 4)),
                    DateTime.now().add(const Duration(days: 3))),
              ),
              Text(
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
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Current Cycle',
                            style: TextStyle(
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              height: 1.33,
                              color: Color(0xFF0F2F5B),
                            ),
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     HistoryPageApi.deleteAllItem();
                          //     nextPage(context, PeriodsLog(selectDateForPeriodsLogs: selectedDate,));
                          //   },
                          //   child: Row(
                          //     children: [
                          //       Icon(Icons.edit_rounded,
                          //           size: 17, color: Color(0xff777777)),
                          //       SizedBox(
                          //         width: 4,
                          //       ),
                          //       Text(
                          //         'Edit dates',
                          //         style: TextStyle(color: Color(0xff777777)),
                          //       )
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 28),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
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
                                  ? colorCardRed
                                  : (index >=
                                  UserData.periodStartDate.day +
                                      UserData.flowDays.value +
                                      5 &&
                                  index <=
                                      UserData.periodStartDate.day +
                                          UserData.flowDays.value +
                                          10)
                                  ? colorCardGreen
                                  : (index <
                                  (UserData
                                      .periodStartDate.day) &&
                                  index >
                                      UserData.periodStartDate.day -
                                          3)
                                  ? colorCardBlue
                                  : Color(0xffDEDEDE),
                              // customColor: (index) => (index >=
                              //     periodStartDate.day - 1 &&
                              //     index <=
                              //         periodStartDate.day + flowDays - 1)
                              //     ? colorCardRed
                              //     : (index >= fertileWindowStart - 1 &&
                              //     index <= fertileWindowEnd - 1)
                              //     ? colorCardGreen
                              //     : (index < (periodStartDate.day - 2) &&
                              //     index > periodStartDate.day - 6)
                              //     ? 3
                              //     : Color(0xffDEDEDE),
                            ),
                            if (showCircle())
                              Row(
                                children: [
                                  SizedBox(width: getCirclePosition()),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: colorCardRed,
                                        size: 22,
                                      ),
                                      Text(
                                        UserData.periodStartDate.day.toString(),
                                        // DateTime.now().day.toString(),
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.white),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
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
                      HistoryPageApi.savedHistoryDataModel.value.isNotEmpty
                          ? ListView.builder(
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
                                      Icon(
                                        Icons.circle,
                                        size: 8,
                                        color: Color(0xff6359A6),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        data[index].date,
                                        // getHistoryData().toString(),
                                        // HistoryPageApi.historyPageModel[index].date.toString(),
                                        style: TextStyle(
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
                                        Icon(Icons.edit_rounded,
                                            size: 17,
                                            color: Color(0xff777777)),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'Edit',
                                          style: TextStyle(
                                              color: Color(0xff777777)),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
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
                                            style:
                                            TextStyle(fontSize: 12))
                                      ],
                                    ),
                                  );
                                }),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          );
                        },
                      )
                          : Row(
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
                      //     HistoryPageApi.savedHistoryDataModel.value.length,
                      //     itemBuilder: (BuildContext context, int index) {
                      //       final data =
                      //       HistoryPageApi.savedHistoryDataModel.value[index];
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
                      //             children: List.generate(data.length, (index) {
                      //               final dataOfDate = data[index];
                      //               return Padding(
                      //                 padding: const EdgeInsets.all(12),
                      //                 child: Column(
                      //                   children: [
                      //                     SvgPicture.asset(
                      //                         dataOfDate.imagePath),
                      //                     Text(dataOfDate.title,
                      //                         textAlign: TextAlign.center,
                      //                         style: TextStyle(fontSize: 12))
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
              SizedBox(
                height: 35,
              ),
              Container(
                height: 44.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
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
                    borderRadius: const BorderRadius.all(
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

                    if (HistoryPageApi.savedHistoryDataModel.value.isNotEmpty) {
                      createTestPdf();
                    } else {
                      showSnackbar(
                          context, "No period history is saved", colorError);
                    }

                    // createPDF();
                    // savePDF();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent),
                  child: Text('Download Period History'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final pdf = pw.Document();

  // createTestPdf() async {
  //   // Future<void> svgStrings = getHistoryData();
  //   if (true) {
  //     List<Map<String, dynamic>> images = [];
  //     for (int i = 0; i < HistoryPageApi.savedHistoryDataModel.length; i++) {
  //       final data = HistoryPageApi.savedHistoryDataModel[i];
  //       final date = data[i].date;
  //       images = await HistoryPageApi.getItemByDateTime(date);
  //     }
  //     final svgWidgets = [];
  //     for (Map<String, dynamic> image in images) {
  //       // final svgData = image['svgData'];
  //       // final svgPicture = SvgPicture.string(svgData);
  //       // final pictureRecorder = ui.PictureRecorder();
  //       // final canvas = Canvas(pictureRecorder);
  //       // final svgPictureDrawable = svgPicture.createDrawable();
  //       // svgPictureDrawable.draw(canvas);
  //       // final picture = pictureRecorder.endRecording();
  //       // final img = await picture.toImage(100, 100);
  //       // final pngBytes = (await img.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  //       // final imageWidget = pw.Image(pw.MemoryImage(pngBytes));
  //       // svgWidgets.add(imageWidget);
  //     }
  //     // if (await Permission.storage.request().isGranted) {
  //     final pdf = pw.Document();
  //     // final data = await getHistoryData();
  //     // final svgImage = pw.SvgImage(svg: dataOfDate.imagePath);
  //     // customPrint("PDF before savedHistoryDataModel :: ${HistoryPageApi.savedHistoryDataModel.value[0].length}");
  //     customPrint(
  //         "PDF before savedHistoryDataModel :: ${HistoryPageApi.savedHistoryDataModel.value.length}");
  //     pdf.addPage(
  //       pw.Page(
  //         // theme: myTheme,
  //         build: (pw.Context context) => pw.Padding(
  //             padding: pw.EdgeInsets.all(12),
  //             child: pw.Column(
  //               children: [
  //                 pw.Text(prefs.getString(LocalStorage.userName) ?? ""),
  //                 pw.Text("Monthly Period History"),
  //                 pw.Column(
  //                     children: List.generate(
  //                         HistoryPageApi.savedHistoryDataModel.value.length,
  //                             (columnIndex) {
  //                           final data =
  //                           HistoryPageApi.savedHistoryDataModel.value[columnIndex];
  //                           customPrint("PDF savedHistoryDataModel :: ${data.length}");
  //                           return pw.Container(
  //                             margin: pw.EdgeInsets.symmetric(vertical: 8),
  //                             padding:
  //                             pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
  //                             decoration: pw.BoxDecoration(
  //                                 border: pw.Border.all(
  //                                     width: 1, color: PdfColor.fromHex("DEDEDE")),
  //                                 color: PdfColor.fromHex("F5F5F5")),
  //                             // color:  PdfColor.fromHex("0xffF5F5F5"),
  //                             child: pw.Padding(
  //                               padding: pw.EdgeInsets.only(top: 10, right: 5),
  //                               child: pw.Row(
  //                                 children: [
  //                                   pw.Padding(
  //                                     padding: const pw.EdgeInsets.all(10.0),
  //                                     child: pw.Container(
  //                                       decoration: pw.BoxDecoration(
  //                                           border: pw.Border.all(
  //                                               width: 1,
  //                                               color: PdfColor.fromHex("000000"))),
  //                                       child: pw.Padding(
  //                                         padding: const pw.EdgeInsets.all(10.0),
  //                                         child: pw.Column(
  //                                           children: [
  //                                             pw.Text(
  //                                               '${data[columnIndex].date.split("-")[0]}',
  //                                               style: pw.TextStyle(fontSize: 16),
  //                                             ),
  //                                             pw.Text(
  //                                                 '${data[columnIndex].date.split("-")[1]} ${data[columnIndex].date.split("-")[2]}',
  //                                                 style: pw.TextStyle(fontSize: 8))
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   pw.Expanded(
  //                                     child: pw.Wrap(
  //                                         spacing: 16,
  //                                         runSpacing: 10,
  //                                         direction: pw.Axis.horizontal,
  //                                         children:
  //                                         List.generate(data.length, (rowIndex) {
  //                                           final dataOfDate = data[rowIndex];
  //                                           customPrint(
  //                                               "PDF data.length  ::: ${data.length}");
  //                                           customPrint(    "PDF dataOfDate.title ::: ${dataOfDate.title}");
  //                                           customPrint(
  //                                               "PDF data.HistoryPageApi.savedHistoryDataModel.value.length  ::: ${HistoryPageApi.savedHistoryDataModel.value.length}");
  //
  //                                           // final svgPath = 'path/to/your/svg_file.svg';
  //                                           //
  //                                           // // Load the SVG file
  //                                           // final svgData = File(svgPath).readAsStringSync();
  //                                           return pw.Column(
  //                                             children: [
  //                                               // pw.Image(pw.ImageImage(imageA)),
  //                                               // pw.Image(PdfImagePage.fromUri(img.uri, PagePosition.center)),
  //                                               pw.SvgImage(
  //                                                   svg:dataOfDate.imagePathSvg ),
  //                                               // pw.SvgImage(svg: dataOfDate.imagePath ),
  //                                               // SvgPicture.asset('images/Mediumf.svg'),
  //                                               pw.Text(
  //                                                 '${dataOfDate.title}',
  //                                                 style: pw.TextStyle(
  //                                                     color: PdfColor.fromHex("000000"),
  //                                                     fontSize: 10),
  //                                               ),
  //                                             ],
  //                                           );
  //                                         })),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           );
  //                         }))
  //               ],
  //             )),
  //         // build: (pw.Context context) => pw.Center(
  //         //   child: pw.ListView(children: [
  //         //     pw.Column(
  //         //       crossAxisAlignment: pw.CrossAxisAlignment.start,
  //         //       children: [
  //         //         pw.Text(
  //         //           prefs.getString(LocalStorage.userName) ?? "",
  //         //           style: pw.TextStyle(
  //         //               fontWeight: pw.FontWeight.bold, fontSize: 22),
  //         //         ),
  //         //         pw.SizedBox(
  //         //           height: 6,
  //         //         ),
  //         //         pw.Text(
  //         //           'Monthly Period History',
  //         //           style: pw.TextStyle(
  //         //               fontWeight: pw.FontWeight.bold, fontSize: 14),
  //         //         ),
  //         //         pw.SizedBox(
  //         //           height: 18,
  //         //         ),
  //         //         pw.Padding(
  //         //           padding: pw.EdgeInsets.only(top: 10, right: 5),
  //         //           child: pw.Row(
  //         //             children: [
  //         //               pw.Padding(
  //         //                 padding: const pw.EdgeInsets.all(10.0),
  //         //                 child: pw.Padding(
  //         //                   padding: const pw.EdgeInsets.all(10.0),
  //         //                   child: pw.Column(
  //         //                       // children: [Text('01', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),), Text('Nov 2023', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 8))],
  //         //                       ),
  //         //                 ),
  //         //               ),
  //         //             ],
  //         //           ),
  //         //         ),
  //         //         pw.ListView.builder(
  //         //           itemCount: HistoryPageApi.savedHistoryDataModel.length,
  //         //           itemBuilder: (pw.Context context, int index) {
  //         //             final data = HistoryPageApi.savedHistoryDataModel[index];
  //         //             // List of perticular date;
  //         //             return pw.Column(
  //         //               crossAxisAlignment: pw.CrossAxisAlignment.start,
  //         //               children: [
  //         //                 pw.Row(
  //         //                   children: [
  //         //                     pw.SizedBox(width: 8),
  //         //                     pw.Text(
  //         //                       data[index].date,
  //         //                       // getHistoryData().toString(),
  //         //                       // HistoryPageApi.historyPageModel[index].date.toString(),
  //         //                       style: pw.TextStyle(fontSize: 12),
  //         //                     )
  //         //                   ],
  //         //                 ),
  //         //                 pw.SizedBox(
  //         //                   height: 8,
  //         //                 ),
  //         //                 pw.Wrap(
  //         //                   children: List.generate(data.length, (index) {
  //         //                     final dataOfDate = data[index];
  //         //                     return pw.Padding(
  //         //                       padding: pw.EdgeInsets.all(12),
  //         //                       child: pw.Column(
  //         //                         children: [
  //         //                           // pw.SvgImage(
  //         //                           //   svg: dataOfDate.imagePath,
  //         //                           //   width: 100,
  //         //                           //   height: 100,
  //         //                           // ),
  //         //                           pw.Text(
  //         //                             dataOfDate.title,
  //         //                             textAlign: pw.TextAlign.center,
  //         //                             style: pw.TextStyle(fontSize: 12),
  //         //                           ),
  //         //                         ],
  //         //                       ),
  //         //                     );
  //         //                   }),
  //         //                 ),
  //         //                 // pw.GridView(
  //         //                 //   crossAxisCount: 5,
  //         //                 //   children: List.generate(data.length, (index) {
  //         //                 //     final dataOfDate = data[index];
  //         //                 //     return pw.Padding(
  //         //                 //       padding: const pw.EdgeInsets.all(12),
  //         //                 //       child: pw.Column(
  //         //                 //         children: [
  //         //                 //           pw.SvgImage(svg: dataOfDate.imagePath),
  //         //                 //           pw.Text(dataOfDate.title,
  //         //                 //               textAlign: pw.TextAlign.center,
  //         //                 //               style: pw.TextStyle(fontSize: 12))
  //         //                 //         ],
  //         //                 //       ),
  //         //                 //     );
  //         //                 //   }),
  //         //                 // ),
  //         //                 pw.SizedBox(
  //         //                   height: 8,
  //         //                 ),
  //         //               ],
  //         //             );
  //         //           },
  //         //         )
  //         //       ],
  //         //     )
  //         //   ]),
  //         // ),
  //       ),
  //     );
  //     // Share.shareFiles([pdf], text: 'Reports');
  //     //replace your code to save file from bellow
  //     // final output = await getApplicationDocumentsDirectory();
  //     final output = (await getExternalStorageDirectory())!;
  //     if (!await output.exists()) {
  //       await output.create(recursive: true);
  //     }
  //     final path = "${output.path}/${DateTime.now().millisecondsSinceEpoch}.pdf";
  //     final file = await io.File(path).writeAsBytes(await pdf.save());
  //     customPrint("file :: ${file.path}");
  //     customPrint("File exists :: ${await file.exists()}");
  //     OpenFile.open(file.path);
  //   }
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
                  pw.Text(prefs.getString(LocalStorage.userName) ?? "",
                      style: pw.TextStyle(
                        fontSize: 26,
                        fontStyle: pw.FontStyle.normal,
                        fontWeight: pw.FontWeight.bold,
                      )),
                  pw.Text(
                      "Monthly Period History ${DateFormat('MMM').format(DateTime(selectedDate.year, selectedDate.month, selectedDate.day))}",
                      style: pw.TextStyle(
                          fontSize: 18, color: PdfColor.fromHex("8D8D8D"))),
                  pw.SizedBox(height: constants.defaultPadding / 2),
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
                                padding: const pw.EdgeInsets.only(right: 5),
                                child: pw.Row(
                                  children: [
                                    pw.Padding(
                                      padding: const pw.EdgeInsets.all(10.0),
                                      child: pw.Container(
                                        decoration: pw.BoxDecoration(
                                          borderRadius: pw.BorderRadius.all(
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
                                              pw.Text(
                                                  '${DateFormat('MMM').format(DateTime(int.parse(data[columnIndex].date.split("-")[2]), int.parse(data[columnIndex].date.split("-")[1]), int.parse(data[columnIndex].date.split("-")[0])))} ${data[columnIndex].date.split("-")[2]}',
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
                                              crossAxisAlignment:
                                              pw.CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              pw.MainAxisAlignment.center,
                                              children: [
                                                // pw.Image(pw.ImageImage(imageA)),
                                                // pw.Image(PdfImagePage.fromUri(img.uri, PagePosition.center)),
                                                pw.SvgImage(svg: dataOfDate.imagePathSvg),
                                                pw.SizedBox(
                                                    height:
                                                    constants.defaultPadding / 2),
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

  // createTestPdf() async {
  //   Future<void> svgStrings = getHistoryData();
  //   if (true) {
  //     // if (await Permission.storage.request().isGranted) {
  //     final pdf = pw.Document();
  //     // final data = await getHistoryData();
  //     // final svgImage = pw.SvgImage(svg: dataOfDate.imagePath);
  //     pdf.addPage(
  //       pw.Page(
  //         // theme: myTheme,
  //         build: (pw.Context context) => pw.Center(
  //           child: pw.ListView(children: [
  //             pw.Column(
  //               crossAxisAlignment: pw.CrossAxisAlignment.start,
  //               children: [
  //                 pw.Text(
  //                   prefs.getString(LocalStorage.userName) ?? "",
  //                   style: pw.TextStyle(
  //                       fontWeight: pw.FontWeight.bold, fontSize: 22),
  //                 ),
  //                 pw.SizedBox(
  //                   height: 6,
  //                 ),
  //                 pw.Text(
  //                   'Monthly Period History',
  //                   style: pw.TextStyle(
  //                       fontWeight: pw.FontWeight.bold, fontSize: 14),
  //                 ),
  //                 pw.SizedBox(
  //                   height: 18,
  //                 ),
  //                 pw.Padding(
  //                   padding: pw.EdgeInsets.only(top: 10, right: 5),
  //                   child: pw.Row(
  //                     children: [
  //                       pw.Padding(
  //                         padding: const pw.EdgeInsets.all(10.0),
  //                         child: pw.Padding(
  //                           padding: const pw.EdgeInsets.all(10.0),
  //                           child: pw.Column(
  //                             // children: [Text('01', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),), Text('Nov 2023', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 8))],
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 pw.ListView.builder(
  //                   itemCount: HistoryPageApi.savedHistoryDataModel.length,
  //                   itemBuilder: (pw.Context context, int index) {
  //                     final data = HistoryPageApi.savedHistoryDataModel[index];
  //                     // List of perticular date;
  //                     return pw.Column(
  //                       crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                       children: [
  //                         pw.Row(
  //                           children: [
  //                             pw.SizedBox(width: 8),
  //                             pw.Text(
  //                               data[index].date,
  //                               // getHistoryData().toString(),
  //                               // HistoryPageApi.historyPageModel[index].date.toString(),
  //                               style: pw.TextStyle(fontSize: 12),
  //                             )
  //                           ],
  //                         ),
  //                         pw.SizedBox(
  //                           height: 8,
  //                         ),
  //                         pw.GridView(
  //                           crossAxisCount: 5,
  //                           children: List.generate(data.length, (index) {
  //                             final dataOfDate = data[index];
  //                             return pw.Padding(
  //                               padding: const pw.EdgeInsets.all(12),
  //                               child: pw.Column(
  //                                 children: [
  //                                   pw.SvgImage(svg: dataOfDate.imagePath),
  //                                   pw.Text(dataOfDate.title,
  //                                       textAlign: pw.TextAlign.center,
  //                                       style: pw.TextStyle(fontSize: 12))
  //                                 ],
  //                               ),
  //                             );
  //                           }),
  //                         ),
  //                         pw.SizedBox(
  //                           height: 8,
  //                         ),
  //                       ],
  //                     );
  //                   },
  //                 )
  //               ],
  //             )
  //           ]),
  //         ),
  //       ),
  //     );
  //     // Share.shareFiles([pdf], text: 'Reports');
  //     //replace your code to save file from bellow
  //     // final output = await getApplicationDocumentsDirectory();
  //     final output = (await getExternalStorageDirectory())!;
  //     if (!await output.exists()) {
  //       await output.create(recursive: true);
  //     }
  //     final path =
  //         "${output.path}/${DateTime.now().millisecondsSinceEpoch}.pdf";
  //     final file = await io.File(path).writeAsBytes(await pdf.save());
  //     customPrint("file :: ${file.path}");
  //     customPrint("File exists :: ${await file.exists()}");
  //     OpenFile.open(file.path);
  //   }
  // }

  Future<void> getHistoryData() async {
    // final date = prefs.getString(LocalStorage.userFirstDay)!;
    // customPrint("getHistoryData Date :: $date");
    // String date = "30-4-2023";
    // DateTime dateTime = DateFormat("dd-MM-yyyy").parse(prefs.getString(LocalStorage.userFirstDay)!);
    customPrint("getHistoryData selectedDate :: $selectedDate");
    DateTime dateTimeConvert = DateFormat("dd-MM-yyyy").parse(
        "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}");
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
    day.isBefore(lastDayOfMonth.add(Duration(days: 1)));
    day = day.add(Duration(days: 1))) {
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
      customPrint("getItemByDateTime loop selectedDate :: $selectedDate");
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
        customPrint(
            "getHistoryData loop data by date :: ${jsonEncode(dataByDate)}");

        setState(() {});
      }

      customPrint(
          "====================================================================");
    }
  }

  // Future<void> getHistoryData() async {
  //   // final date = prefs.getString(LocalStorage.userFirstDay)!;
  //   // customPrint("getHistoryData Date :: $date");
  //   // String date = "30-4-2023";
  //   DateTime dateTime = DateFormat("dd-MM-yyyy")
  //       .parse(prefs.getString(LocalStorage.userFirstDay)!);
  //   int cycle =
  //   int.parse(prefs.getString(LocalStorage.userFlowDuration) ?? "0");
  //   String date = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
  //   customPrint("cycle :: $cycle");
  //   customPrint("date :: $date");
  //   customPrint("dateTime :: ${dateTime.toString().split(" ")[0]}");
  //   // HistoryPageApi.savedHistoryDataModel.clear();
  //   // final data = await HistoryPageApi.getItemByDateTime(date.toString());
  //   // final singleData = historyPageModelFromJson(jsonEncode(data));
  //   // if (singleData.isNotEmpty) {
  //   //   HistoryPageApi.savedHistoryDataModel.add(singleData);
  //   //   customPrint("getHistoryData :: ${jsonEncode(data)}");
  //   //   setState(() {});
  //   // }
  //   HistoryPageApi.savedHistoryDataModel.clear();
  //   for (int i = 0; i < cycle; i++) {
  //     dateTime= dateTime.add(Duration(days: i));
  //     date = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
  //     customPrint("getItemByDateTime Date :: $date");
  //     final data = await HistoryPageApi.getItemByDateTime(date.toString());
  //     // final data = await HistoryPageApi.getItemByDateTime(UserData.periodStartDate.add(Duration(days: i)).toString());
  //     final singleData = historyPageModelFromJson(jsonEncode(data));
  //     if (singleData.isNotEmpty) {
  //       HistoryPageApi.savedHistoryDataModel.add(singleData);
  //       customPrint("getHistoryData $i :: ${jsonEncode(data)}");
  //       setState(() {});
  //     }
  //   }
  // }

  double getCirclePosition() {
    double maxPosition = MediaQuery.of(context).size.width - 70;
    double minPosition = 0;

    double difference = maxPosition - minPosition;
    customPrint("difference :: $difference");
    int division = (difference / 30).round();
    customPrint("division :: $division");
    int durationCycle =
    int.parse(prefs.getString(LocalStorage.userFlowDuration) ?? "0");
    DateTime endDate = periodStartDate.add(Duration(days: durationCycle));
    // int diffDays = periodStartDate.difference(endDate).inDays;
    // int todayDay = DateTime.now().day;
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
    DateTime endDate = periodStartDate.add(Duration(days: durationCycle));
    if ((DateTime.now().isAfter(periodStartDate) ||
        DateTime.now().isAtSameMomentAs(periodStartDate)) &&
        (DateTime.now().isBefore(endDate) ||
            DateTime.now().isAtSameMomentAs(endDate))) {
      return true;
    }
    // return false;
    return true;
  }
}
