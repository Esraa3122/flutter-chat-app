import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Map<String, String>?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint("===============Location services are disabled.===============");
      return null; 
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint("===============Location permissions are denied.===============");
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint("===============Location permissions are permanently denied.===============");
      return null; 
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition();
      String addressName = "unknown_location".tr(); 
      debugPrint("=============================================================Current Position: Lat=${position.latitude}, Lng=${position.longitude}");

      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
        if (placemarks.isNotEmpty) {
          Placemark placemark = placemarks.first;
          
          List<String> addressParts = [];
          if (placemark.street != null && placemark.street!.isNotEmpty) addressParts.add(placemark.street!);
          if (placemark.locality != null && placemark.locality!.isNotEmpty) addressParts.add(placemark.locality!);
          if (placemark.country != null && placemark.country!.isNotEmpty) addressParts.add(placemark.country!);
          debugPrint("===============================================Address Parts: $addressParts");
          if (addressParts.isNotEmpty) {
            addressName = addressParts.join(", ");
          }
        }
      } catch (e) {
        debugPrint("Geocoding Error: $e");
      }

      return {
        'lat': position.latitude.toString(),
        'lng': position.longitude.toString(),
        'address': addressName,
      };
    }

    return null;
  }
}