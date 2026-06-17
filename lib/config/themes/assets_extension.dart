import 'package:e_chat/core/utils/app_images.dart';
import 'package:flutter/material.dart';

class MyAssets extends ThemeExtension<MyAssets> {
  const MyAssets({
    required this.logoEChat,
  });

  final String? logoEChat;

  @override
  ThemeExtension<MyAssets> copyWith({
    String? logoEChat,
  }) {
    return MyAssets(
      logoEChat: logoEChat,
    );
  }

  @override
  ThemeExtension<MyAssets> lerp(
    covariant ThemeExtension<MyAssets>? other,
    double t,
  ) {
    if (other is! MyAssets) {
      return this;
    }
    return MyAssets(
      logoEChat: logoEChat,
    );
  }

  static const MyAssets dark = MyAssets(
    logoEChat: AppImages.appLogoImgDark,
  );
  static const MyAssets light = MyAssets(
    logoEChat: AppImages.appLogoImgLight,
  );
}
