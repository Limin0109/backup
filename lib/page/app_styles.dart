import 'package:flutter/material.dart';
import './size_configs.dart';

Color kPrimaryColor = Color(0xff00e676);
Color kSecondaryColor = Color(0xff1b5e20);
Color kTertiaryColor = Color(0xff2962ff);

final kTitle = TextStyle(
  fontFamily: 'Klasik',
  fontSize: SizeConfig.blockSizeH! * 7,
  color: kSecondaryColor,
);

final kFocus = TextStyle(
  fontFamily: 'Klasik',
  fontSize: SizeConfig.blockSizeH! * 7,
  color: kTertiaryColor,
  fontWeight: FontWeight.bold,
);

final kBodyText1 = TextStyle(
  color: kSecondaryColor,
  fontSize: SizeConfig.blockSizeH! * 4.5,
  fontWeight: FontWeight.bold,
);