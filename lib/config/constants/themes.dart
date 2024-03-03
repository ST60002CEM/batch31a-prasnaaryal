import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF843667);
const kSecondaryColor = Color(0xDFEFB42C);
const kFourthColor = Color(0xFF022238);
const kFifthColor = Color.fromARGB(255, 199, 204, 207);
const kThirdColor = Color(0xFFFFDCBC);
const kLightBackground = Color(0xFFE8F6FB);
const kWhiteColor = Colors.white;
const kBlackColor = Colors.black;

class ThemeConstant {
  ThemeConstant._();

  static const Color darkPrimaryColor = kBlackColor;
  static const Color primaryColor = kPrimaryColor;
  static const Color appBarColor = kSecondaryColor;

  static const kBigTitle =
      TextStyle(color: kWhiteColor, fontSize: 25, fontWeight: FontWeight.bold);

  static const kHeadingOne =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  static const kSeeAllText = TextStyle(color: kPrimaryColor);

  static final kBodyText = TextStyle(color: Colors.grey.shade500, fontSize: 12);

  static const kCardTitle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
}
