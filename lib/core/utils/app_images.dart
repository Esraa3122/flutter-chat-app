import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class AppImages {
  static const String path = 'assets/images';
  static const String appLogoImgLight = '$path/e_chat_app_logo.png';
  static const String appLogoImgDark = '$path/e_chat_app_logo_dark.png';
  static const String bG = '$path/BG.png';
  static const String bgEmptyChatScreen = '$path/Share.json';
  static const String nonDataFound = '$path/non data found.json';
  static const String loading = '$path/Loading Dots Blue.json';

  static Widget showImg({
    required String imgPath,
    double? width,
    double? height,
  }) {
    if (imgPath.endsWith('.svg')) {
      return SvgPicture.asset(imgPath, width: width, height: height);
    }
    if (imgPath.endsWith('.json')) {
      return Lottie.asset(imgPath, width: width, height: height);
    } else {
      return Image.asset(imgPath, width: width, height: height);
    }
  }
}
