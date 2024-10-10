import 'dart:developer';
import '../utils/serializable/locations.dart' as locations;
import 'package:cubework_app_client/utils/serializable/locations.dart';

Future<List<Office>> fetchLocation() async {
  try {
  final data = await locations.getUnitOfferingLocations();
  return data.offices;
  } catch (err) {
  // Replace print with a logging framework
  log('Error fetching locations: $err');
  rethrow;
  }
}
