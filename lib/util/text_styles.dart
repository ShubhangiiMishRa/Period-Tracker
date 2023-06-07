library my_prj.globals;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class textStyle {
  ///heading
  static final TextStyle heading =
  TextStyle(color: colorDark, fontWeight: FontWeight.bold, fontSize: 20.sp);

  static final TextStyle headingReg =
  TextStyle(color: colorDark, fontSize: 20.sp);

  static final TextStyle headingsemibold = TextStyle(
      color: colorDark,
      fontWeight: FontWeight.w700,
      fontSize: 20.sp,
      fontFamily: 'poppinssemibold');

  static final TextStyle headingLight = TextStyle(
      color: colorDark,
      // fontWeight: FontWeight.w700,
      fontSize: 20.sp,
      fontFamily: 'poppinslight');

  ///subheading
  static final TextStyle subHeading = TextStyle(
      color: colorSubHeadingText,
      fontWeight: FontWeight.normal,
      fontSize: 16.sp);

  static final TextStyle subHeadingSemibold = TextStyle(
      color: colorSubHeadingText,
      fontFamily: 'poppinssemibold',
      fontWeight: FontWeight.normal,
      fontSize: 16.sp);

  static final TextStyle subHeadingSemibold2 = TextStyle(
      color: colorSubHeadingText,
      fontFamily: 'poppinssemibold',
      fontWeight: FontWeight.normal,
      fontSize: 16.sp);

  static final TextStyle subHeadingLigh = TextStyle(
      color: colorSubHeadingText,
      fontFamily: 'poppinslight',
      fontWeight: FontWeight.normal,
      fontSize: 16.sp);

  static final TextStyle subHeadingColorDark =
  subHeading.copyWith(color: colorHeadingText, fontWeight: FontWeight.bold);

  ///small text
  static final TextStyle smallTextColorDark = TextStyle(
      color: colorSubHeadingText, fontWeight: FontWeight.bold, fontSize: 13.sp);

  static final TextStyle smallTextSemiBoldDark = TextStyle(
      color: colorSubHeadingText,
      fontFamily: 'poppinssemibold',
      fontWeight: FontWeight.w500,
      fontSize: 13.sp);

  static final TextStyle smallText = TextStyle(
      color: colorSubHeadingText,
      fontWeight: FontWeight.normal,
      fontSize: 13.sp);

  static final TextStyle smallTextSemiBold = TextStyle(
      color: colorSubHeadingText,
      fontFamily: 'poppinssemibold',
      fontWeight: FontWeight.w300,
      fontSize: 13.sp);

  static final TextStyle smallTextLight = TextStyle(
      color: colorSubHeadingText,
      fontFamily: 'poppinslight',
      fontWeight: FontWeight.normal,
      fontSize: 13.sp);

  static final TextStyle button = TextStyle(
      color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18.sp);

  static final TextStyle subButton = TextStyle(
      color: Colors.white, fontWeight: FontWeight.normal, fontSize: 14.sp);
}
