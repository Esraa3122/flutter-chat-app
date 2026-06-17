import 'package:e_chat/core/app_constants/context_ext.dart';
import 'package:e_chat/core/utils/app_colors.dart';
import 'package:e_chat/core/utils/font_details.dart';
import 'package:e_chat/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  Future<void> _showLanguageMenu(BuildContext context) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    final selected = await showMenu<Locale>(
      color: context.color.popupMenu,
      context: context,
      position: position,
      items: [
        PopupMenuItem<Locale>(
          value: const Locale('en'),
          child: Row(
            children: [
              CustomTextWidget(text: '🇬🇧', textStyle: TextStyle(fontSize: FontDetails.fontSizeM)),
              const SizedBox(width: 8),
              CustomTextWidget(text: 'english'.tr(), textStyle: TextStyle(color: context.color.textColor,fontSize: FontDetails.fontSizeM),),
              if (context.locale.languageCode == 'en')
                Padding(
                  padding: EdgeInsets.only(left: 8.w, right: 8.h),
                  child: Icon(Icons.check, size: FontDetails.fontSizeM, color: context.color.textColor,),
                ),
            ],
          ),
        ),
        PopupMenuItem<Locale>(
          value: const Locale('ar'),
          child: Row(
            children: [
              CustomTextWidget(text: '🇸🇦',textStyle: TextStyle(fontSize: FontDetails.fontSizeM)),
              const SizedBox(width: 8),
              CustomTextWidget(text: 'arabic'.tr(), textStyle: TextStyle(color: context.color.textColor,fontSize: FontDetails.fontSizeM),),
              if (context.locale.languageCode == 'ar')
                Padding(
                  padding: EdgeInsets.only(left: 8.h),
                  child: Icon(Icons.check, size: FontDetails.fontSizeM, color: context.color.textColor,),
                ),
            ],
          ),
        ),
      ],
    );

    if (selected != null && context.mounted) {
      await context.setLocale(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (innerContext) => IconButton(
        icon: Icon(Icons.language, color: ColorsLight.white,size: FontDetails.fontSizeL,),
        tooltip: 'language'.tr(),
        onPressed: () => _showLanguageMenu(innerContext),
      ),
    );
  }
}
