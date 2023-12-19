import 'package:geolocator/geolocator.dart';
import 'package:weather_flutter/core/enums/location_status.dart';
import 'package:weather_flutter/core/util/geo_model.dart';

final class PermissionUtil {
  static Future<LocationInfo> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return const LocationInfo(locationStatus: LocationStatus.serviceUnavailable, geoModel: null);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return const LocationInfo(locationStatus: LocationStatus.denied, geoModel: null);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return const LocationInfo(locationStatus: LocationStatus.denied, geoModel: null);
    }

    final pos = await Geolocator.getCurrentPosition();

    return LocationInfo(
      locationStatus: LocationStatus.approve,
      geoModel: GeoModel(lat: pos.latitude, long: pos.longitude),
    );
  }
}
