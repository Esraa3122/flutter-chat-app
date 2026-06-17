import 'package:e_chat/core/app_constants/context_ext.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet {
  const CustomBottomSheet._();

  static void showModalBottomSheetContainer({
    required BuildContext context,
    required Widget widget,
    Color? backgroundColor,
    VoidCallback? whenComplete,
  }) =>
      showModalBottomSheet<dynamic>(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          showDragHandle: true,
          context: context,
          backgroundColor: backgroundColor ?? context.color.chatBackgroundColor,
          isScrollControlled: true,
          barrierColor: Colors.transparent,
          builder: (context) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: widget,
                ),
              ),
            );
          }).whenComplete(whenComplete ?? () {});
}
