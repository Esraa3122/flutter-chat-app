import 'dart:convert';
import 'package:e_chat/core/services/contact_service.dart';
import 'package:e_chat/core/services/location_service.dart';
import 'package:easy_localization/easy_localization.dart';

mixin AttachmentSenderMixin {

  LocationService get locationService;

  ContactService get contactService;

  Future<String?> buildLocationPayload() async {

    final position = await locationService.getCurrentLocation();

    if (position == null) return null;

    return jsonEncode(position);

  }

  Future<String?> buildContactPayload() async {

    final contact = await contactService.pickContact();

    if (contact == null || contact.phones.isEmpty) return null;

    final name = (contact.displayName ?? "contact_without_a_name".tr()).trim();

    return jsonEncode({"name": name, "phone": contact.phones.first.number});

  }

}