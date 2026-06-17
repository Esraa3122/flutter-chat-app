import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactService {
  Future<Contact?> pickContact() async {
    var status = await Permission.contacts.request();

    if (status.isGranted) {
      return await FlutterContacts.native.showPicker(
        properties: {
          ContactProperty.name, 
          ContactProperty.phone
        },
      );
    }
    
    return null; 
  }
}