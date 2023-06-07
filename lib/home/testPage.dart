import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class MonthPickerPage extends StatefulWidget {
  const MonthPickerPage({Key? key}) : super(key: key);

  @override
  State<MonthPickerPage> createState() => _MonthPickerPageState();
}

class _MonthPickerPageState extends State<MonthPickerPage> {
  DateTime? selectedDate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('en'),
        Locale('zh'),
        Locale('fr'),
        Locale('es'),
        Locale('de'),
        Locale('ru'),
        Locale('ja'),
        Locale('ar'),
        Locale('fa'),
        Locale('es'),
        Locale('it'),
      ],
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
              .copyWith(secondary: Colors.pinkAccent)),
      home: Scaffold(
        body: Center(
          child: Text(
            'Year: ${selectedDate?.year}\nMonth: ${selectedDate?.month}',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
        ),
                floatingActionButton: Builder(
          builder: (BuildContext context) => FloatingActionButton(
            onPressed: () {

              showMonthPicker(
                context: context,
                firstDate: DateTime(DateTime.now().year - 5, 5),
                lastDate: DateTime(DateTime.now().year + 8, 9),
                initialDate: selectedDate ?? DateTime.now(),
                locale: const Locale('en'),
                //show only even months

                selectableMonthPredicate: (DateTime val) => val.month.isEven,
                monthStylePredicate: (DateTime val) {
                  if (val.month == 4) {
                    return TextButton.styleFrom(
                      backgroundColor: Colors.yellow[700],
                      textStyle: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                  return null;
                },
                yearStylePredicate: (int val) {
                  if (val == 2022) {
                    return TextButton.styleFrom(
                      backgroundColor: Colors.yellow[700],
                      textStyle: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                  return null;
                },
                headerColor: Colors.amber[900],
                headerTextColor: Colors.black,
                selectedMonthBackgroundColor: Colors.amber[900],
                selectedMonthTextColor: Colors.white,
                unselectedMonthTextColor: Colors.green,
                confirmWidget: Text(
                  'This one!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.amber[900],
                  ),
                ),
                cancelWidget: Text(
                  'Cancel',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.amber[900],
                  ),
                ),
                yearFirst: true,
                backgroundColor: Colors.yellow[100],
                forceSelectedDate: true,
                dismissible: true,
                capitalizeFirstLetter: true,
                customHeight: 500,
                customWidth: 500,
                // dismissible: true,
                // forceSelectedDate: true,
              ).then((DateTime? date) {
                if (date != null) {
                  setState(() {
                    selectedDate = date;
                  });
                }
              });
            },
            child: const Icon(Icons.calendar_today),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:month_picker_dialog/month_picker_dialog.dart';
// import 'package:month_picker_dialog/month_picker_dialog.dart';
//
// class MyApp extends StatefulWidget {
//   MyApp({Key? key}) : super(key: key);
//   final DateTime initialDate;
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
// class _MyAppState extends State<MyApp> {
//   DateTime? selectedDate;
//
//   @override
//   void initState() {
//     super.initState();
//     selectedDate = widget.initialDate;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       supportedLocales: const <Locale>[
//         Locale('en'),
//         Locale('zh'),
//         Locale('fr'),
//         Locale('es'),
//         Locale('de'),
//         Locale('ru'),
//         Locale('ja'),
//         Locale('ar'),
//         Locale('fa'),
//         Locale('es'),
//         Locale('it'),
//       ],
//       theme: ThemeData(
//           colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
//               .copyWith(secondary: Colors.pinkAccent)),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Month Picker Example App'),
//         ),
//         body: Center(
//           child: Text(
//             'Year: ${selectedDate?.year}\nMonth: ${selectedDate?.month}',
//             style: Theme.of(context).textTheme.headlineMedium,
//             textAlign: TextAlign.center,
//           ),
//         ),
//         floatingActionButton: Builder(
//           builder: (BuildContext context) => FloatingActionButton(
//             onPressed: () {
//               showMonthPicker(
//                 context: context,
//                 firstDate: DateTime(DateTime.now().year - 5, 5),
//                 lastDate: DateTime(DateTime.now().year + 8, 9),
//                 initialDate: selectedDate ?? widget.initialDate,
//                 locale: const Locale('en'),
//                 //show only even months
//
//                 // selectableMonthPredicate: (DateTime val) => val.month.isEven,
//                 // monthStylePredicate: (DateTime val) {
//                 //   if (val.month == 4) {
//                 //     return TextButton.styleFrom(
//                 //       backgroundColor: Colors.yellow[700],
//                 //       textStyle: TextStyle(
//                 //         color: Colors.pink,
//                 //         fontWeight: FontWeight.bold,
//                 //       ),
//                 //     );
//                 //   }
//                 //   return null;
//                 // },
//                 // yearStylePredicate: (int val) {
//                 //   if (val == 2022) {
//                 //     return TextButton.styleFrom(
//                 //       backgroundColor: Colors.yellow[700],
//                 //       textStyle: TextStyle(
//                 //         color: Colors.pink,
//                 //         fontWeight: FontWeight.bold,
//                 //       ),
//                 //     );
//                 //   }
//                 //   return null;
//                 // },
//                 // headerColor: Colors.amber[900],
//                 // headerTextColor: Colors.black,
//                 // selectedMonthBackgroundColor: Colors.amber[900],
//                 // selectedMonthTextColor: Colors.white,
//                 // unselectedMonthTextColor: Colors.green,
//                 // confirmWidget: Text(
//                 //   'This one!',
//                 //   style: TextStyle(
//                 //     fontWeight: FontWeight.bold,
//                 //     color: Colors.amber[900],
//                 //   ),
//                 // ),
//                 // cancelWidget: Text(
//                 //   'Cancel',
//                 //   style: TextStyle(
//                 //     fontWeight: FontWeight.bold,
//                 //     color: Colors.amber[900],
//                 //   ),
//                 // ),
//                 // yearFirst: true,
//                 // backgroundColor: Colors.yellow[100],
//                 //forceSelectedDate: true,
//                 //dismissible: true,
//                 // capitalizeFirstLetter: true,
//                 // customHeight: 500,
//                 // customWidth: 500,
//                 // dismissible: true,
//                 // forceSelectedDate: true,
//               ).then((DateTime? date) {
//                 if (date != null) {
//                   setState(() {
//                     selectedDate = date;
//                   });
//                 }
//               });
//             },
//             child: const Icon(Icons.calendar_today),
//           ),
//         ),
//       ),
//     );
//   }
// }
