import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppImages {
  static const String path = 'assets/images';
  static const String appLogoImgLight = '$path/e_chat_app_logo..png';
  static const String appLogoImgDark = '$path/e_chat_app_logo_dark.png';
  static const String bG = '$path/BG.png';

  static Widget showImg({
    required String imgPath,
    double? width,
    double? height,
  }) {
    if (imgPath.endsWith('.svg')) {
      return SvgPicture.asset(imgPath, width: width, height: height);
    } else {
      return Image.asset(imgPath, width: width, height: height);
    }
  }
}
