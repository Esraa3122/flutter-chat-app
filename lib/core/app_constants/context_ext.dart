import 'package:e_chat/config/themes/assets_extension.dart';
import 'package:e_chat/config/themes/color_extension.dart';
import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  MyColor get color => Theme.of(this).extension<MyColor>()!;

  MyAssets get images => Theme.of(this).extension<MyAssets>()!;
  
}
