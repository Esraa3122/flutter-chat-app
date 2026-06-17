import 'package:e_chat/config/themes/assets_extension.dart';
import 'package:e_chat/config/themes/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/font_details.dart';

ThemeData themeDark() {
  return ThemeData(
      scaffoldBackgroundColor: ColorsDark.mainColor,
      extensions: const <ThemeExtension<dynamic>>[MyColor.dark, MyAssets.dark],
      useMaterial3: true,
      textTheme: const TextTheme(
          displaySmall: TextStyle(
              fontSize: 14,
              color: ColorsDark.white,
              )));
}

ThemeData themeLight() {
  return ThemeData(
      scaffoldBackgroundColor: ColorsLight.mainColor,
      extensions: const <ThemeExtension<dynamic>>[
        MyColor.light,
        MyAssets.light
      ],
      useMaterial3: true,
      textTheme: const TextTheme(
          displaySmall: TextStyle(
              fontSize: 14,
              color: ColorsLight.black,
            )));
}

ThemeData appTheme() {
  return ThemeData(
      primaryColor: ColorsDark.blueDark,
      hintColor: ColorsLight.hintColor,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: FontDetails.fontFamilyName,
      textTheme: TextTheme(
        displayLarge: TextStyle(
            fontWeight: FontDetails.boldFontWeight,
            color: ColorsDark.blueDark,
            fontSize: FontDetails.fontSizeXL),
        displayMedium: TextStyle(
            fontWeight: FontDetails.mediumFontWeight,
            color: ColorsDark.blueDark,
            fontSize: FontDetails.fontSizeM),
        displaySmall: TextStyle(
            fontWeight: FontDetails.mediumFontWeight,
            color: ColorsDark.blueDark,
            fontSize: FontDetails.fontSizeS),

        ///-----------------
        headlineLarge: TextStyle(
            fontWeight: FontDetails.boldFontWeight,
            color: ColorsDark.white,
            fontSize: FontDetails.fontSizeL),
        headlineMedium: TextStyle(
            fontWeight: FontDetails.mediumFontWeight,
            color: ColorsDark.white,
            fontSize: FontDetails.fontSizeM),
        headlineSmall: TextStyle(
            fontWeight: FontDetails.regularFontWeight,
            color: ColorsDark.white,
            fontSize: FontDetails.fontSizeXS),

        ///-----------------
        titleSmall: TextStyle(
            fontWeight: FontDetails.mediumFontWeight,
            color: ColorsLight.black,
            fontSize: FontDetails.fontSizeXS),
        titleMedium: TextStyle(
            fontWeight: FontDetails.semiBoldFontWeight,
            color: ColorsLight.black,
            fontSize: FontDetails.fontSizeM),
        titleLarge: TextStyle(
            fontWeight: FontDetails.semiBoldFontWeight,
            color: ColorsLight.black,
            fontSize: FontDetails.fontSizeL),

        ///-----------------
        // labelSmall: ,
        // labelMedium: ,
        // labelLarge: ,

        ///-----------------
        bodySmall: TextStyle(
            fontWeight: FontDetails.mediumFontWeight,
            color: ColorsLight.mainTextColor,
            fontSize: FontDetails.fontSizeXS),
        bodyMedium: TextStyle(
            fontWeight: FontDetails.mediumFontWeight,
            color: ColorsLight.mainTextColor,
            fontSize: FontDetails.fontSizeM),
        bodyLarge: TextStyle(
            fontWeight: FontDetails.mediumFontWeight,
            color: ColorsLight.mainTextColor,
            fontSize: FontDetails.fontSizeL),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(ColorsDark.mainColor),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r))),
          textStyle: MaterialStateProperty.resolveWith(
            (states) => TextStyle(
              fontWeight: FontDetails.mediumFontWeight,
              fontSize: FontDetails.fontSizeM,
              color: ColorsDark.white,
            ),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(ColorsDark.mainColor),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.r))),
          textStyle: MaterialStateProperty.resolveWith(
            (states) => TextStyle(
              fontWeight: FontDetails.mediumFontWeight,
              fontSize: FontDetails.fontSizeM,
              color: ColorsDark.white,
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.r))),
          textStyle: MaterialStateProperty.resolveWith(
            (states) => TextStyle(
              fontWeight: FontDetails.mediumFontWeight,
              fontSize: FontDetails.fontSizeM,
              color: ColorsDark.blueDark,
            ),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: ColorsLight.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.r))),
      ));
}
