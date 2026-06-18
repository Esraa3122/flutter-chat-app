import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  Future<void> sendMail() async {
    final Uri mail = Uri.parse("mailto:");
    launchUrl(mail, mode: LaunchMode.externalApplication);
  }

  Future<void> callPhone(String phoneNumber) async {
    final Uri tel = Uri.parse("tel:$phoneNumber");
    launchUrl(tel, mode: LaunchMode.externalApplication);
  }

  Future<void> openMap(String lat, String lng) async {
    final String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    final Uri url = Uri.parse(googleMapsUrl);
    
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch Map';
    }
  }
  
}
