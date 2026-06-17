import 'package:e_chat/config/app/app_cubit/app_cubit.dart';
import 'package:e_chat/config/themes/app_theme.dart';
import 'package:e_chat/core/helpers/shared_prefrences.dart';
import 'package:e_chat/core/utils/font_details.dart';
import 'package:e_chat/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<AppCubit>()
                ..changeAppThemeMode('dark_mode',
                    sharedMode: CacheHelper().getData(key: 'mode') ?? false),
            ),
          ],
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              final cubit = context.read<AppCubit>();
              return MaterialApp.router(
                theme: themeLight().copyWith(
                  textTheme: themeLight().textTheme.apply(
                        fontFamily:
                            FontFamilyHelper.getLocalizedFontFamily(context),
                      ),
                ),
                darkTheme: themeDark().copyWith(
                  textTheme: themeDark().textTheme.apply(
                        fontFamily:
                            FontFamilyHelper.getLocalizedFontFamily(context),
                      ),
                ),
                themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
                debugShowCheckedModeBanner: false,
                title: 'Flutter Task',
                routerConfig: AppRoutes.router,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
              );
            },
          ),
        );
      },
    );
  }
}
