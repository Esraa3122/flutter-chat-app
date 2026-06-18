import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_chat/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageMessageContent extends StatelessWidget {
  const ImageMessageContent({
    super.key,
    required this.isNetworkImage,
    required this.message,
  });

  final bool isNetworkImage;
  final String message;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: isNetworkImage
          ? CachedNetworkImage(
              imageUrl: message,
              placeholder: (context, url) => SizedBox(
                width: 150.w,
                height: 150.h,
                child: const Center(
                  child: CircularProgressIndicator(color: ColorsLight.blueLight1),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.image_not_supported_outlined,
                size: 50,
                color: ColorsLight.mainTextColor,
              ),
              width: 200.w,
              fit: BoxFit.cover,
            )
          : Image.file(
              File(message),
              width: 200.w,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.broken_image,
                size: 50,
                color: ColorsLight.mainTextColor,
              ),
            ),
    );
  }
}