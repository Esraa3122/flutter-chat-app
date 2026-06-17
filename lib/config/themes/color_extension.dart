import 'package:e_chat/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MyColor extends ThemeExtension<MyColor> {
  const MyColor({
    required this.mainColor,
    required this.chatBackgroundColor,
    required this.textColor,
    required this.textFormBorder,
    required this.popupMenu,
    required this.circleAvatarBackgroundColor,
  });
  final Color? mainColor;
  final Color? chatBackgroundColor;
  final Color? textColor;
  final Color? textFormBorder;
  final Color? popupMenu;
  final Color? circleAvatarBackgroundColor;


  @override
  ThemeExtension<MyColor> copyWith({
    Color? mainColor,
    Color? chatBackgroundColor,
    Color? textColor,
    Color? textFormBorder,
    Color? popupMenu,
    Color? circleAvatarBackgroundColor,
  }) {
    return MyColor(
      mainColor: mainColor,
      chatBackgroundColor: chatBackgroundColor,
      textColor: textColor,
      textFormBorder: textFormBorder,
      popupMenu: popupMenu,
      circleAvatarBackgroundColor: circleAvatarBackgroundColor,
    );
  }

  @override
  ThemeExtension<MyColor> lerp(
      covariant ThemeExtension<MyColor>? other, double t) {
    if (other is! MyColor) {
      return this;
    }
    return MyColor(
      mainColor: mainColor,
      chatBackgroundColor: chatBackgroundColor,
      textColor: textColor,
      textFormBorder: textFormBorder,
      popupMenu: popupMenu,
      circleAvatarBackgroundColor: circleAvatarBackgroundColor,
    );
  }

  static const MyColor dark = MyColor(
    mainColor: ColorsDark.mainColor,
    chatBackgroundColor: ColorsDark.chatBackgroundColor,
    textColor: ColorsDark.white,
    textFormBorder: ColorsDark.blueLight2,
    popupMenu: ColorsDark.popupMenuDark,
    circleAvatarBackgroundColor: ColorsDark.blueDark,
  );
  static const MyColor light = MyColor(
    mainColor: ColorsLight.mainColor,
    chatBackgroundColor: ColorsLight.chatBackgroundColor,
    textColor: ColorsLight.black,
    textFormBorder: ColorsLight.blueLight1,
    popupMenu: ColorsLight.mainColor,
    circleAvatarBackgroundColor: ColorsLight.backgroundColorCircleButtonblue3,
  );
}
