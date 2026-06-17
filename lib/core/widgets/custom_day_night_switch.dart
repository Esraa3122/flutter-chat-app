import 'package:day_night_themed_switcher/day_night_themed_switcher.dart';
import 'package:e_chat/config/app/app_cubit/app_cubit.dart';
import 'package:e_chat/core/utils/font_details.dart';
import 'package:flutter/material.dart';

class CustomDayNightSwitch extends StatelessWidget {
  final AppCubit cubit;
  const CustomDayNightSwitch({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DayNightSwitch(
        initiallyDark: cubit.isDark,
        size: FontDetails.fontSizeL,
            onChange: (val) =>
                cubit.changeAppThemeMode('dark_mode', sharedMode: val),
          ),
    );
  }
}
