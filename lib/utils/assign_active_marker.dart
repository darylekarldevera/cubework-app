import 'package:cubework_app_client/models/warehouse.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void assignActiveMarker(
    Warehouse warehouse, GoogleMapController mapController) {
  Future.delayed(const Duration(milliseconds: 500), () {
    mapController.showMarkerInfoWindow(MarkerId(warehouse.name));
  });
}
