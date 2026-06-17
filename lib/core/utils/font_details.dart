import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FontDetails {
  static String fontFamilyName = '';

  static FontWeight blackFontWeight = FontWeight.w900;
  static FontWeight extraBoldFontWeight = FontWeight.w800;
  static FontWeight boldFontWeight = FontWeight.w700;
  static FontWeight semiBoldFontWeight = FontWeight.w600;
  static FontWeight mediumFontWeight = FontWeight.w500;
  static FontWeight regularFontWeight = FontWeight.w400;
  static FontWeight lightFontWeight = FontWeight.w300;
  static FontWeight extraLightFontWeight = FontWeight.w200;
  static FontWeight thinFontWeight = FontWeight.w100;

  static double fontSizeXS = 12.sp;
  static double fontSizeS = 14.sp;
  static double fontSizeM = 16.sp;
  static double fontSizeL = 23.sp;
  static double fontSizeXL = 30.sp;
}

class FontFamilyHelper {
  FontFamilyHelper._();

  static const String cairoArabic = 'Cairo';
  static const String sFProEnglish = 'SF-Pro';

  static String getLocalizedFontFamily(BuildContext context) {
    final currentLanguage = context.locale.languageCode; 

    if (currentLanguage == 'ar') {
      return cairoArabic;
    } else {
      return sFProEnglish;
    }
  }
}