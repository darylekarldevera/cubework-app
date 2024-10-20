import 'package:geolocator/geolocator.dart';

Future<void> requestGeolocatorPermission() async {
  try {
    LocationPermission permission;

    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  } catch (e) {
    throw Exception('Error at request geolocator permission: $e'); // Print error if any
  }
}
