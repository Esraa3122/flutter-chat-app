import 'package:e_chat/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset(AppImages.loading),);
  }
}