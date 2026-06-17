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
      context: context,
      position: position,
      items: [
        PopupMenuItem<Locale>(
          value: const Locale('en'),
          child: Row(
            children: [
              const Text('🇬🇧'),
              const SizedBox(width: 8),
              Text('english'.tr()),
              if (context.locale.languageCode == 'en')
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(Icons.check, size: 16),
                ),
            ],
          ),
        ),
        PopupMenuItem<Locale>(
          value: const Locale('ar'),
          child: Row(
            children: [
              const CustomTextWidget(text: '🇸🇦'),
              const SizedBox(width: 8),
              CustomTextWidget(text: 'arabic'.tr()),
              if (context.locale.languageCode == 'ar')
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(Icons.check, size: 16),
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
        icon: const Icon(Icons.language),
        tooltip: 'language'.tr(),
        onPressed: () => _showLanguageMenu(innerContext),
      ),
    );
  }
}

class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    return ElevatedButton.icon(
      onPressed: () {
        if (isArabic) {
          context.setLocale(const Locale('en'));
        } else {
          context.setLocale(const Locale('ar'));
        }
      },
      icon: const Icon(Icons.language),
      label: CustomTextWidget(text: isArabic ? 'english'.tr() : 'arabic'.tr()),
    );
  }
}

class LanguageTextButton extends StatelessWidget {
  const LanguageTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    return TextButton(
      onPressed: () {
        if (isArabic) {
          context.setLocale(const Locale('en'));
        } else {
          context.setLocale(const Locale('ar'));
        }
      },
      child: CustomTextWidget(
        text: isArabic ? 'english'.tr() : 'arabic'.tr(),
        textStyle: TextStyle(fontSize: 16.sp),
      ),
    );
  }
}
