import 'package:e_chat/core/helpers/shared_prefrences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

   bool isDark = false;

    Future<void> changeAppThemeMode(String key, {bool? sharedMode}) async {
    if (key == 'dark_mode') {
      
      if (sharedMode != null) {
        isDark = sharedMode;
      } else {
        isDark = !isDark;
      }

      await CacheHelper().saveData(key: 'mode', val: isDark);
      
      emit(ThemeChangeMode(isDark: isDark));
    }
  }
}
