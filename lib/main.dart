import 'package:e_chat/app.dart';
import 'package:e_chat/core/helpers/hive_helper.dart';
import 'package:e_chat/core/observers/bloc_observer.dart';
import 'package:e_chat/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();
  EasyLocalization.ensureInitialized();
  await getItInit();
  await getIt<HiveHelper>().init();

  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/languages',
      fallbackLocale: const Locale('en'),
      child: const MyApp()));
}