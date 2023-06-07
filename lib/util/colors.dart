import 'package:flutter/material.dart';

const Color colorAccent = Color(0xFF269991);
// const Color colorDark = Color(0xff48DEB1);
const Color colorDark = Color(0xff0d56b8);
const Color colorDarkWallet = Color(0xff0d56b8);
const Color colorCardWhite = Color(0xFFf3f3f3);
const Color colorCardBlue = Color(0xFF39B2DA);
const Color colorCardRed = Color(0xFFF92A2A);
const Color colorCardGreen = Color(0xFF9BCB3B);
const Color colorCardLight = Color(0xffeff4ff);
const Color colorCard = Color(0xfff3f3f3);
const Color colorHeadingText = Color(0xff404040);
const Color colorSubHeadingText = Color(0xff898888);
const Color colorSubHeadingText1 = Color(0xffF0F0F0);
const Color imageBg = Color(0xffF6F6F6);
const Color colorWarning = Colors.orangeAccent;
const Color colorSuccess = Colors.green;
const Color colorError = Colors.redAccent;
const Color colorWhite = Colors.white;
const Color colorBlack = Colors.black;
const Color colorDisable = Color(0xffEBEBE4);
const Color colorButtton = Color(0xff509F3D);
const Color colorBorder = Color(0xffF5C601);
const Color colorBgLight = Color(0xffF9F9F9);

List<Color> graphGradientColor() {
  return [
    Colors.white38,
    Colors.white30,
    Colors.white24,
    Colors.white12,
    Colors.white10,
  ];
}

class AppColors {
  static const Color home1 = Color(0xff29adff);
  static const Color home2 = Color(0xffea1d24);
  static const Color home3 = Color(0xff00a348);
  static const Color home4 = Color(0xffdec010);
  static const Color player1 = Color(0xff29adff);
  static const Color player2 = Color(0xffea1d24);
  static const Color player3 = Color(0xff00a348);
  static const Color player4 = Color(0xffdec010);
  static const Color safeSpot = Color(0xffC0C0C0);
}

Map<int, Color> color = {
  50: const Color.fromRGBO(13, 86, 184, .1),
  100: const Color.fromRGBO(13, 86, 184, .2),
  200: const Color.fromRGBO(13, 86, 184, .3),
  300: const Color.fromRGBO(13, 86, 184, .4),
  400: const Color.fromRGBO(13, 86, 184, .5),
  500: const Color.fromRGBO(13, 86, 184, .6),
  600: const Color.fromRGBO(13, 86, 184, 0.7),
  700: const Color.fromRGBO(13, 86, 184, .8),
  2090: const Color.fromRGBO(13, 86, 184, .9),
  900: const Color.fromRGBO(13, 86, 184, 1),
};

MaterialColor colorCustom = MaterialColor(0xff0d56b8, color);
