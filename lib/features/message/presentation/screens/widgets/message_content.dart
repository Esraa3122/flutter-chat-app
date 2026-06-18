import 'dart:convert';
import 'package:e_chat/core/utils/app_colors.dart';
import 'package:e_chat/core/utils/font_details.dart';
import 'package:e_chat/features/message/presentation/screens/widgets/contact_message_content.dart';
import 'package:e_chat/features/message/presentation/screens/widgets/image_message_content.dart';
import 'package:e_chat/features/message/presentation/screens/widgets/location_message_content.dart';
import 'package:e_chat/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension;
import 'package:flutter/material.dart';

class MessageContent extends StatelessWidget {
  final String type;
  final String message;
  final bool isMe;

  const MessageContent({
    super.key,
    required this.type,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    if (type == "image") {
      final isNetworkImage = message.startsWith('http');

      return ImageMessageContent(isNetworkImage: isNetworkImage, message: message);
    } else if (type == "location") {
      Map<String, dynamic> locData = {};
      try {
        locData = jsonDecode(message);
      } catch (e) {
        locData = {'lat': '0', 'lng': '0', 'address': "unknown_location".tr()};
      }

      final String lat = locData['lat'] ?? '0';
      final String lng = locData['lng'] ?? '0';
      final String address = locData['address'] ?? "unknown_location".tr();

      return LocationMessageContent(lat: lat, lng: lng, isMe: isMe, address: address);
    } else if (type == "contact") {
      Map<String, dynamic> contactData = {};
      try {
        contactData = jsonDecode(message);
      } catch (e) {
        contactData = {"name": "unknown".tr(), "phone": ""};
      }
      return ContactMessageContent(isMe: isMe, contactData: contactData);
    }  else {
      return CustomTextWidget(
        text: message,
        textStyle: TextStyle(
          color: isMe ? ColorsLight.white : ColorsLight.black,
          fontSize: FontDetails.fontSizeS,
        ),
      );
    }
  }
}




