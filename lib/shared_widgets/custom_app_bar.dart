import 'package:e_chat/core/app_constants/context_ext.dart';
import 'package:e_chat/core/services/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar customAppBar(BuildContext context){
return AppBar(
        backgroundColor: context.color.mainColor,
        elevation: 0,
        leading: CustomFadeInRight(
          duration: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: context.color.textColor!.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new,
                    color: context.color.textColor, size: 18.sp),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
      );
}