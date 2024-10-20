import 'package:geolocator/geolocator.dart';

Future<Position> getMyPosition() async {
  try {
    var serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    );

    Position position =
        await Geolocator.getCurrentPosition(locationSettings: locationSettings)
            .timeout(const Duration(seconds: 5));

    return position;
  } catch (e) {
    throw Exception('Error at getting position: $e'); // Print error if any
  }
}
