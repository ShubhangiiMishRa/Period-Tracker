import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nexus/api/local_storage.dart';
import 'dart:io';
// import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
class PdfPage extends StatefulWidget {
  const PdfPage({Key? key}) : super(key: key);

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
final pdf=pw.Document();
 //pdf.addPage()

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(LocalStorage.userName, style: TextStyle(
                    fontFamily: 'Mulish', fontWeight: FontWeight.w600, fontSize: 22, color: Color(0xff191919)
                  ),),
                  SizedBox(height: 6,),
                  Text('Monthly Period History', style: TextStyle(
                      fontFamily: 'Mulish', fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xff8D8D8D)
                  ),),
                ],
              ),
            ),
            SizedBox(height: 18,),
            Card(
              color: Color(0xffF5F5F5),
              child: Padding(
                padding: EdgeInsets.only(top: 10, right: 5),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [Text('01', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),), Text('Nov 2023', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 8))],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 10,
                        direction: Axis.horizontal,
                        children: [
                          Column(
                            children: [
                              SvgPicture.asset('images/Mediumf.svg'),
                              Text('Medium', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xffDB4D46), fontSize: 10),),
                            ],
                          ),
                          Column(
                            children: [
                              SvgPicture.asset('images/Distractedf.svg'),
                              Text('Distracted\n', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xff874C48), fontSize: 10),),
                            ],
                          ),
                          Column(
                            children: [
                              SvgPicture.asset('images/MiniPillf.svg'),
                              Text('Mini\nPill', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xff9CADCE), fontSize: 10),),
                            ],
                          ),
                          Column(
                            children: [
                              SvgPicture.asset('images/Headachef.svg'),
                              Text('Headache\n', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xff946DAE), fontSize: 10),),
                            ],
                          ),
                          // Column(
                          //   children: [
                          //     SvgPicture.asset('images/Happyf.svg'),
                          //     Text('Happy\n', textAlign: TextAlign.center,
                          //       style: TextStyle(
                          //           color: Color(0xff874C48), fontSize: 10),),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: Color(0xffF5F5F5),
              child: Padding(
                padding: EdgeInsets.only(top: 10, right: 5),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [Text('02', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),), Text('Nov 2023', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 8))],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 10,
                        direction: Axis.horizontal,
                        children: [
                          Column(
                            children: [
                              SvgPicture.asset('images/Distractedf.svg'),
                              Text('Distracted\n', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xff874C48), fontSize: 10),),
                            ],
                          ),
                          Column(
                            children: [
                              SvgPicture.asset('images/Mediumf.svg'),
                              Text('Medium', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xffDB4D46), fontSize: 10),),
                            ],
                          ),

                          Column(
                            children: [
                              SvgPicture.asset('images/Ovulationf.svg'),
                              Text('Injection\n', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xff946DAE), fontSize: 10),),
                            ],
                          ),

                          Column(
                            children: [
                              SvgPicture.asset('images/MiniPillf.svg'),
                              Text('Mini\nPill', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xff9CADCE), fontSize: 10),),
                            ],
                          ),
                          Column(
                            children: [
                              SvgPicture.asset('images/Headachef.svg'),
                              Text('Headache\n', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xff946DAE), fontSize: 10),),
                            ],
                          ),
                          Column(
                            children: [
                              SvgPicture.asset('images/Happyf.svg'),
                              Text('Happy\n', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xff874C48), fontSize: 10),),
                            ],
                          ),
                          Column(
                            children: [
                              SvgPicture.asset('images/Injectionf.svg'),
                              Text('Injection\n', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xff9CADCE), fontSize: 10),),
                            ],
                          ),
                          Column(
                            children: [
                              SvgPicture.asset('images/Distractedf.svg'),
                              Text('Distracted\n', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xff874C48), fontSize: 10),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: Color(0xffF5F5F5),
              child: Padding(
                padding: EdgeInsets.only(top: 10, right: 5),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [Text('03', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),), Text('Nov 2023', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 8))],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 10,
                        direction: Axis.horizontal,
                        children: [
                          Column(
                            children: [
                              SvgPicture.asset('images/CombinedPillf.svg'),
                              Text('Combined\nPills', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xff946DAE), fontSize: 10),),
                            ],
                          ),

                          Column(
                            children: [
                              SvgPicture.asset('images/Injectionf.svg'),
                              Text('Injection\n', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xff946DAE), fontSize: 10),),
                            ],
                          ),

                          Column(
                            children: [
                              SvgPicture.asset('images/Injectionf.svg'),
                              Text('Injection\n', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xff946DAE), fontSize: 10),),
                            ],
                          ),
                          Column(
                            children: [
                              SvgPicture.asset('images/MiniPillf.svg'),
                              Text('Mini\nPill', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xff946DAE), fontSize: 10),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: Color(0xffF5F5F5),
              child: Padding(
                padding: EdgeInsets.only(top: 10, right: 5),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [Text('04', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),), Text('Nov 2023', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 8))],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 10,
                        direction: Axis.horizontal,
                        children: [
                          Column(
                            children: [
                              SvgPicture.asset('images/CombinedPillf.svg'),
                              Text('Combined\nPills', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xff946DAE), fontSize: 10),),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: Color(0xffF5F5F5),
              child: Padding(
                padding: EdgeInsets.only(top: 10, right: 5),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [Text('05', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),), Text('Nov 2023', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 8))],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 10,
                        direction: Axis.horizontal,
                        children: [
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: Color(0xffF5F5F5),
              child: Padding(
                padding: EdgeInsets.only(top: 10, right: 5),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [Text('06', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),), Text('Nov 2023', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 8))],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 10,
                        direction: Axis.horizontal,
                        children: [
                          Column(
                            children: [
                              SvgPicture.asset('images/Injectionf.svg'),
                              Text('Injection\n', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xff946DAE), fontSize: 10),),
                            ],
                          ),
                          Column(
                            children: [
                              SvgPicture.asset('images/MiniPillf.svg'),
                              Text('Mini\nPill', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xff946DAE), fontSize: 10),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
Future<void> main() async{
  final pdf = pw.Document();
  pdf.addPage(pw.Page(
    build: (pw.Context context) => pw.Padding(
        padding: pw.EdgeInsets.all(10),
        child: pw.ListView(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.only(left: 10),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Cameron Williamson', style: pw.TextStyle(
                      // fontFamily: 'Mulish',
                      fontWeight: pw.FontWeight.bold, fontSize: 22,
                      // color: pw.Color(0xff191919)
                  ),),
                  pw.SizedBox(height: 6,),
                  pw.Text('Monthly Period History (Nov 2023)',
                  //   style: TextStyle(
                  //     fontFamily: 'Mulish', fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xff8D8D8D)
                  // ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 18,),
            // Card(
            //   color: Color(0xffF5F5F5),
            //   child: Padding(
            //     padding: EdgeInsets.only(top: 10, right: 5),
            //     child: Row(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.all(10.0),
            //           child: Card(
            //             child: Padding(
            //               padding: const EdgeInsets.all(10.0),
            //               child: Column(
            //                 children: [Text('01', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),), Text('Nov 2023', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 8))],
            //               ),
            //             ),
            //           ),
            //         ),
            //         Expanded(
            //           child: Wrap(
            //             spacing: 16,
            //             runSpacing: 10,
            //             direction: Axis.horizontal,
            //             children: [
            //               Column(
            //                 children: [
            //                   SvgPicture.asset('images/Mediumf.svg'),
            //                   Text('Medium', textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                         color: Color(0xffDB4D46), fontSize: 10),),
            //                 ],
            //               ),
            //               Column(
            //                 children: [
            //                   SvgPicture.asset('images/Distractedf.svg'),
            //                   Text('Distracted\n', textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                         color: Color(0xff874C48), fontSize: 10),),
            //                 ],
            //               ),
            //               Column(
            //                 children: [
            //                   SvgPicture.asset('images/MiniPillf.svg'),
            //                   Text('Mini\nPill', textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                         color: Color(0xff9CADCE), fontSize: 10),),
            //                 ],
            //               ),
            //               Column(
            //                 children: [
            //                   SvgPicture.asset('images/Headachef.svg'),
            //                   Text('Headache\n', textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                         color: Color(0xff946DAE), fontSize: 10),),
            //                 ],
            //               ),
            //               // Column(
            //               //   children: [
            //               //     SvgPicture.asset('images/Happyf.svg'),
            //               //     Text('Happy\n', textAlign: TextAlign.center,
            //               //       style: TextStyle(
            //               //           color: Color(0xff874C48), fontSize: 10),),
            //               //   ],
            //               // ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Card(
            //   color: Color(0xffF5F5F5),
            //   child: Padding(
            //     padding: EdgeInsets.only(top: 10, right: 5),
            //     child: Row(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.all(10.0),
            //           child: Card(
            //             child: Padding(
            //               padding: const EdgeInsets.all(10.0),
            //               child: Column(
            //                 children: [Text('02', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),), Text('Nov 2023', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 8))],
            //               ),
            //             ),
            //           ),
            //         ),
            //         Expanded(
            //           child: Wrap(
            //             spacing: 16,
            //             runSpacing: 10,
            //             direction: Axis.horizontal,
            //             children: [
            //               Column(
            //                 children: [
            //                   SvgPicture.asset('images/Distractedf.svg'),
            //                   Text('Distracted\n', textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                         color: Color(0xff874C48), fontSize: 10),),
            //                 ],
            //               ),
            //               Column(
            //                 children: [
            //                   SvgPicture.asset('images/Mediumf.svg'),
            //                   Text('Medium', textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                         color: Color(0xffDB4D46), fontSize: 10),),
            //                 ],
            //               ),
            //
            //               Column(
            //                 children: [
            //                   SvgPicture.asset('images/Ovulationf.svg'),
            //                   Text('Injection\n', textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                         color: Color(0xff946DAE), fontSize: 10),),
            //                 ],
            //               ),
            //
            //               Column(
            //                 children: [
            //                   SvgPicture.asset('images/MiniPillf.svg'),
            //                   Text('Mini\nPill', textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                         color: Color(0xff9CADCE), fontSize: 10),),
            //                 ],
            //               ),
            //               Column(
            //                 children: [
            //                   SvgPicture.asset('images/Headachef.svg'),
            //                   Text('Headache\n', textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                         color: Color(0xff946DAE), fontSize: 10),),
            //                 ],
            //               ),
            //               Column(
            //                 children: [
            //                   SvgPicture.asset('images/Happyf.svg'),
            //                   Text('Happy\n', textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                         color: Color(0xff874C48), fontSize: 10),),
            //                 ],
            //               ),
            //               Column(
            //                 children: [
            //                   SvgPicture.asset('images/Injectionf.svg'),
            //                   Text('Injection\n', textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                         color: Color(0xff9CADCE), fontSize: 10),),
            //                 ],
            //               ),
            //               Column(
            //                 children: [
            //                   SvgPicture.asset('images/Distractedf.svg'),
            //                   Text('Distracted\n', textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                         color: Color(0xff874C48), fontSize: 10),),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Card(
            //   color: Color(0xffF5F5F5),
            //   child: Padding(
            //     padding: EdgeInsets.only(top: 10, right: 5),
            //     child: Row(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.all(10.0),
            //           child: Card(
            //             child: Padding(
            //               padding: const EdgeInsets.all(10.0),
            //               child: Column(
            //                 children: [Text('03', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),), Text('Nov 2023', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 8))],
            //               ),
            //             ),
            //           ),
            //         ),
            //         Expanded(
            //           child: Wrap(
            //             spacing: 16,
            //             runSpacing: 10,
            //             direction: Axis.horizontal,
            //             children: [
            //               Column(
            //                 children: [
            //                   SvgPicture.asset('images/CombinedPillf.svg'),
            //                   Text('Combined\nPills', textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                         color: Color(0xff946DAE), fontSize: 10),),
            //                 ],
            //               ),
            //
            //               Column(
            //                 children: [
            //                   SvgPicture.asset('images/Injectionf.svg'),
            //                   Text('Injection\n', textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                         color: Color(0xff946DAE), fontSize: 10),),
            //                 ],
            //               ),
            //
            //               Column(
            //                 children: [
            //                   SvgPicture.asset('images/Injectionf.svg'),
            //                   Text('Injection\n', textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                         color: Color(0xff946DAE), fontSize: 10),),
            //                 ],
            //               ),
            //               Column(
            //                 children: [
            //                   SvgPicture.asset('images/MiniPillf.svg'),
            //                   Text('Mini\nPill', textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                         color: Color(0xff946DAE), fontSize: 10),),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Card(
            //   color: Color(0xffF5F5F5),
            //   child: Padding(
            //     padding: EdgeInsets.only(top: 10, right: 5),
            //     child: Row(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.all(10.0),
            //           child: Card(
            //             child: Padding(
            //               padding: const EdgeInsets.all(10.0),
            //               child: Column(
            //                 children: [Text('04', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),), Text('Nov 2023', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 8))],
            //               ),
            //             ),
            //           ),
            //         ),
            //         Expanded(
            //           child: Wrap(
            //             spacing: 16,
            //             runSpacing: 10,
            //             direction: Axis.horizontal,
            //             children: [
            //               Column(
            //                 children: [
            //                   SvgPicture.asset('images/CombinedPillf.svg'),
            //                   Text('Combined\nPills', textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                         color: Color(0xff946DAE), fontSize: 10),),
            //                 ],
            //               ),
            //
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Card(
            //   color: Color(0xffF5F5F5),
            //   child: Padding(
            //     padding: EdgeInsets.only(top: 10, right: 5),
            //     child: Row(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.all(10.0),
            //           child: Card(
            //             child: Padding(
            //               padding: const EdgeInsets.all(10.0),
            //               child: Column(
            //                 children: [Text('05', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),), Text('Nov 2023', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 8))],
            //               ),
            //             ),
            //           ),
            //         ),
            //         Expanded(
            //           child: Wrap(
            //             spacing: 16,
            //             runSpacing: 10,
            //             direction: Axis.horizontal,
            //             children: [
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Card(
            //   color: Color(0xffF5F5F5),
            //   child: Padding(
            //     padding: EdgeInsets.only(top: 10, right: 5),
            //     child: Row(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.all(10.0),
            //           child: Card(
            //             child: Padding(
            //               padding: const EdgeInsets.all(10.0),
            //               child: Column(
            //                 children: [Text('06', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),), Text('Nov 2023', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 8))],
            //               ),
            //             ),
            //           ),
            //         ),
            //         Expanded(
            //           child: Wrap(
            //             spacing: 16,
            //             runSpacing: 10,
            //             direction: Axis.horizontal,
            //             children: [
            //               Column(
            //                 children: [
            //                   SvgPicture.asset('images/Injectionf.svg'),
            //                   Text('Injection\n', textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                         color: Color(0xff946DAE), fontSize: 10),),
            //                 ],
            //               ),
            //               Column(
            //                 children: [
            //                   SvgPicture.asset('images/MiniPillf.svg'),
            //                   Text('Mini\nPill', textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                         color: Color(0xff946DAE), fontSize: 10),),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    )
  );
  final file = File('example.pdf');
  await file.writeAsBytes(await pdf.save());
}
// Future<Uint8List> buildPdf(PdfPageFormat format) async {
//   // Create the Pdf document
//   final pw.Document doc = pw.Document();
//
//   // Add one page with centered text "Hello World"
//   doc.addPage(
//     pw.Page(
//       pageFormat: format,
//       build: (pw.Context context) {
//         return pw.ConstrainedBox(
//           constraints: pw.BoxConstraints.expand(),
//           child: pw.FittedBox(
//             child: pw.Scaffold(
//               backgroundColor: Colors.white,
//               body: Padding(
//                 padding: EdgeInsets.all(10),
//                 child: ListView(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Cameron Williamson', style: TextStyle(
//                               fontFamily: 'Mulish', fontWeight: FontWeight.w600, fontSize: 22, color: Color(0xff191919)
//                           ),),
//                           SizedBox(height: 6,),
//                           Text('Monthly Period History (Nov 2023)', style: TextStyle(
//                               fontFamily: 'Mulish', fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xff8D8D8D)
//                           ),),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 18,),
//                     Card(
//                       color: Color(0xffF5F5F5),
//                       child: Padding(
//                         padding: EdgeInsets.only(top: 10, right: 5),
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: Card(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: Column(
//                                     children: [Text('01', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),), Text('Nov 2023', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 8))],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Wrap(
//                                 spacing: 16,
//                                 runSpacing: 10,
//                                 direction: Axis.horizontal,
//                                 children: [
//                                   Column(
//                                     children: [
//                                       SvgPicture.asset('images/Mediumf.svg'),
//                                       Text('Medium', textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: Color(0xffDB4D46), fontSize: 10),),
//                                     ],
//                                   ),
//                                   Column(
//                                     children: [
//                                       SvgPicture.asset('images/Distractedf.svg'),
//                                       Text('Distracted\n', textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: Color(0xff874C48), fontSize: 10),),
//                                     ],
//                                   ),
//                                   Column(
//                                     children: [
//                                       SvgPicture.asset('images/MiniPillf.svg'),
//                                       Text('Mini\nPill', textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: Color(0xff9CADCE), fontSize: 10),),
//                                     ],
//                                   ),
//                                   Column(
//                                     children: [
//                                       SvgPicture.asset('images/Headachef.svg'),
//                                       Text('Headache\n', textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: Color(0xff946DAE), fontSize: 10),),
//                                     ],
//                                   ),
//                                   // Column(
//                                   //   children: [
//                                   //     SvgPicture.asset('images/Happyf.svg'),
//                                   //     Text('Happy\n', textAlign: TextAlign.center,
//                                   //       style: TextStyle(
//                                   //           color: Color(0xff874C48), fontSize: 10),),
//                                   //   ],
//                                   // ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Card(
//                       color: Color(0xffF5F5F5),
//                       child: Padding(
//                         padding: EdgeInsets.only(top: 10, right: 5),
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: Card(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: Column(
//                                     children: [Text('02', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),), Text('Nov 2023', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 8))],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Wrap(
//                                 spacing: 16,
//                                 runSpacing: 10,
//                                 direction: Axis.horizontal,
//                                 children: [
//                                   Column(
//                                     children: [
//                                       SvgPicture.asset('images/Distractedf.svg'),
//                                       Text('Distracted\n', textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: Color(0xff874C48), fontSize: 10),),
//                                     ],
//                                   ),
//                                   Column(
//                                     children: [
//                                       SvgPicture.asset('images/Mediumf.svg'),
//                                       Text('Medium', textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: Color(0xffDB4D46), fontSize: 10),),
//                                     ],
//                                   ),
//
//                                   Column(
//                                     children: [
//                                       SvgPicture.asset('images/Ovulationf.svg'),
//                                       Text('Injection\n', textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: Color(0xff946DAE), fontSize: 10),),
//                                     ],
//                                   ),
//
//                                   Column(
//                                     children: [
//                                       SvgPicture.asset('images/MiniPillf.svg'),
//                                       Text('Mini\nPill', textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: Color(0xff9CADCE), fontSize: 10),),
//                                     ],
//                                   ),
//                                   Column(
//                                     children: [
//                                       SvgPicture.asset('images/Headachef.svg'),
//                                       Text('Headache\n', textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: Color(0xff946DAE), fontSize: 10),),
//                                     ],
//                                   ),
//                                   Column(
//                                     children: [
//                                       SvgPicture.asset('images/Happyf.svg'),
//                                       Text('Happy\n', textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: Color(0xff874C48), fontSize: 10),),
//                                     ],
//                                   ),
//                                   Column(
//                                     children: [
//                                       SvgPicture.asset('images/Injectionf.svg'),
//                                       Text('Injection\n', textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: Color(0xff9CADCE), fontSize: 10),),
//                                     ],
//                                   ),
//                                   Column(
//                                     children: [
//                                       SvgPicture.asset('images/Distractedf.svg'),
//                                       Text('Distracted\n', textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: Color(0xff874C48), fontSize: 10),),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Card(
//                       color: Color(0xffF5F5F5),
//                       child: Padding(
//                         padding: EdgeInsets.only(top: 10, right: 5),
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: Card(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: Column(
//                                     children: [Text('03', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),), Text('Nov 2023', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 8))],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Wrap(
//                                 spacing: 16,
//                                 runSpacing: 10,
//                                 direction: Axis.horizontal,
//                                 children: [
//                                   Column(
//                                     children: [
//                                       SvgPicture.asset('images/CombinedPillf.svg'),
//                                       Text('Combined\nPills', textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: Color(0xff946DAE), fontSize: 10),),
//                                     ],
//                                   ),
//
//                                   Column(
//                                     children: [
//                                       SvgPicture.asset('images/Injectionf.svg'),
//                                       Text('Injection\n', textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: Color(0xff946DAE), fontSize: 10),),
//                                     ],
//                                   ),
//
//                                   Column(
//                                     children: [
//                                       SvgPicture.asset('images/Injectionf.svg'),
//                                       Text('Injection\n', textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: Color(0xff946DAE), fontSize: 10),),
//                                     ],
//                                   ),
//                                   Column(
//                                     children: [
//                                       SvgPicture.asset('images/MiniPillf.svg'),
//                                       Text('Mini\nPill', textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: Color(0xff946DAE), fontSize: 10),),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Card(
//                       color: Color(0xffF5F5F5),
//                       child: Padding(
//                         padding: EdgeInsets.only(top: 10, right: 5),
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: Card(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: Column(
//                                     children: [Text('04', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),), Text('Nov 2023', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 8))],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Wrap(
//                                 spacing: 16,
//                                 runSpacing: 10,
//                                 direction: Axis.horizontal,
//                                 children: [
//                                   Column(
//                                     children: [
//                                       SvgPicture.asset('images/CombinedPillf.svg'),
//                                       Text('Combined\nPills', textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: Color(0xff946DAE), fontSize: 10),),
//                                     ],
//                                   ),
//
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Card(
//                       color: Color(0xffF5F5F5),
//                       child: Padding(
//                         padding: EdgeInsets.only(top: 10, right: 5),
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: Card(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: Column(
//                                     children: [Text('05', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),), Text('Nov 2023', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 8))],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Wrap(
//                                 spacing: 16,
//                                 runSpacing: 10,
//                                 direction: Axis.horizontal,
//                                 children: [
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Card(
//                       color: Color(0xffF5F5F5),
//                       child: Padding(
//                         padding: EdgeInsets.only(top: 10, right: 5),
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: Card(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: Column(
//                                     children: [Text('06', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),), Text('Nov 2023', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 8))],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Wrap(
//                                 spacing: 16,
//                                 runSpacing: 10,
//                                 direction: Axis.horizontal,
//                                 children: [
//                                   Column(
//                                     children: [
//                                       SvgPicture.asset('images/Injectionf.svg'),
//                                       Text('Injection\n', textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: Color(0xff946DAE), fontSize: 10),),
//                                     ],
//                                   ),
//                                   Column(
//                                     children: [
//                                       SvgPicture.asset('images/MiniPillf.svg'),
//                                       Text('Mini\nPill', textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: Color(0xff946DAE), fontSize: 10),),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     ),
//   );
//
//   // Build and return the final Pdf file data
//   return await doc.save();
// }


