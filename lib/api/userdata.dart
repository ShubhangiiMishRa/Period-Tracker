import 'package:get/get_rx/get_rx.dart';
import 'package:intl/intl.dart';
import 'package:nexus/globalVariable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'local_storage.dart';

class UserData {
  static RxInt numberOfDaysInCycle = int.parse(prefs.getString(LocalStorage.userDaysInCycle)??"28").obs;
  static RxInt flowDays = int.parse(prefs.getString(LocalStorage.userFlowDuration)??"5").obs;
  static DateTime periodStartDate = DateTime(userFirstDayYear,userFirstDayMonth,userFirstDayDay);
  static DateTime periodSelectedDay = DateTime(userSelectedDayYear1,userSelectedDayMonth1,userSelectedDayDay1);
  static RxString date = ('${periodStartDate.day}-${periodStartDate.month}-${periodStartDate.year}').obs;
  static DateTime prevDate = periodStartDate.subtract(Duration(days: (numberOfDaysInCycle.value)));
  static DateTime nextDate = periodStartDate.add(Duration(days: numberOfDaysInCycle.value));
  static bool isLoggedIn = false;
}
