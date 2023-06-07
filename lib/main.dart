// @dart=2.9
import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nexus/Authentication/signup_page.dart';
import 'package:nexus/home/home_page.dart';
import 'package:nexus/login/landing_page.dart';
import 'package:nexus/Authentication/login_page.dart';
import 'package:nexus/login/splash_Screen.dart';
import 'package:nexus/util/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'globalVariable.dart';

SharedPreferences prefs;
const String appName = "Flutter";

// Future<void> backgroundHandler(RemoteMessage message) async {
//   customPrint(message.data.toString());
//   customPrint(message.notification.title);
// }

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

//void main() => runApp(MyApp());
// void main(){
//   HttpOverrides.global=new MyHttpoverrides();
//   runApp(MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    checkDebugMode();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]); //force portrait mode
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ));
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: appName,
            theme: ThemeData(
              primarySwatch: colorCustom,
              fontFamily: "poppins",
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child,
              );
            },

            // home: const SignupPage(email: "Test email",),
            home: const SplashScreen(),
            // home:  LoginPage(),
            // home:  PrivacySettingPage(),
          );
        });
  }
}

// // @dart=2.9
// import 'dart:io';
//
// // import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:nexus/api/local_storage.dart';
// import 'package:nexus/home/home_page.dart';
// import 'package:nexus/login/landing_page.dart';
// import 'package:nexus/Authentication/login_page.dart';
// import 'package:nexus/screens/navigation.dart';
// import 'package:nexus/util/colors.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'api/userdata.dart';
// import 'globalVariable.dart';
//
// SharedPreferences prefs;
// const String appName = "Flutter";
//
// // Future<void> backgroundHandler(RemoteMessage message) async {
// //   customPrint(message.data.toString());
// //   customPrint(message.notification.title);
// // }
//
// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }
//
// //void main() => runApp(MyApp());
// // void main(){
// //   HttpOverrides.global=new MyHttpoverrides();
// //   runApp(MyApp());
// // }
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   prefs = await SharedPreferences.getInstance();
//   WidgetsFlutterBinding.ensureInitialized();
//   HttpOverrides.global = MyHttpOverrides();
//   runApp(MyApp());
// }
//
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//   class _MyAppState extends State<MyApp>{
//     @override
//     void initState() {
//       super.initState();
//       checkLoginStatus();
//     }
//
//     Future<void> checkLoginStatus() async {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       UserData.isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
//       setState(() {});
//     }
//   static String KEYLOGIN = "Login";
//   @override
//   Widget build(BuildContext context) {
//     checkDebugMode();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown
//     ]); //force portrait mode
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       systemNavigationBarColor: Colors.white,
//       statusBarIconBrightness: Brightness.light,
//       statusBarColor: Colors.transparent,
//     ));
//     return ScreenUtilInit(
//         designSize: const Size(360, 690),
//         minTextAdapt: true,
//         builder: (context, child) {
//           return GetMaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: appName,
//             theme: ThemeData(
//               primarySwatch: colorCustom,
//               // fontFamily: "poppins",
//               fontFamily: "OpenSans",
//               visualDensity: VisualDensity.adaptivePlatformDensity,
//             ),
//             builder: (context, child) {
//               return MediaQuery(
//                 data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
//                 child: child,
//               );
//             },
//             // home: const SignupPage(email: "Test email",),
//             // home: UserData.isLoggedIn?const LandingPage():const NavigatorPage(),
//             home: LandingPage(),
//             // home:  DatePickerPage(),
//             // home:  PrivacySettingPage(),
//           );
//         });
//   }
//
// }
