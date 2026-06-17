import 'package:e_chat/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomLinearButton extends StatelessWidget {
  const CustomLinearButton({
    required this.onPressed,
    required this.child,
    this.height,
    this.width,
    super.key,
  });

  final VoidCallback onPressed;
  final Widget child;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: ColorsLight.backgroundColorCircleButtonblue3.withOpacity(0.3),
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: height ?? 44,
        width: width ?? 44,
        decoration: BoxDecoration(
         gradient: const LinearGradient(
          colors: [
            ColorsLight.backgroundColorCircleButtonblue3,
            ColorsDark.blueLight2,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(child: child),
      ),
    );
  }
}
