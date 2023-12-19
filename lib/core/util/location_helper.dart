import 'package:geocoding/geocoding.dart';

mixin LocationHelper {
  static Future<String?> cityNameFromCoordinates(double? lat, double? long) async {
    if (lat == null || long == null) return "";
    final placemarks = await placemarkFromCoordinates(lat, long);
    if (placemarks.isEmpty) return null;

    return placemarks.first.administrativeArea;
  }
}
