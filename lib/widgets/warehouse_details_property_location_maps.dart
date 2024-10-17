import 'package:flutter/material.dart';
import 'package:cubework_app_client/models/warehouse.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cubework_app_client/utils/assign_active_marker.dart';

class WarehouseDetailsPropertyLocationMaps extends StatelessWidget {
  final Warehouse warehouse;
  const WarehouseDetailsPropertyLocationMaps({super.key, required this.warehouse});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(warehouse.location.lat, warehouse.location.lng),
              zoom: 15,
            ),
          ));

          assignActiveMarker(warehouse, controller);
        },
        markers: Set<Marker>.of({
          Marker(
            markerId: MarkerId(warehouse.name),
            position: LatLng(warehouse.location.lat, warehouse.location.lng),
            infoWindow: InfoWindow(
              title: warehouse.name,
              snippet: warehouse.location.address,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            consumeTapEvents: false,
          )
        }),
        initialCameraPosition: CameraPosition(
          target: LatLng(warehouse.location.lat, warehouse.location.lng),
          zoom: 15,
        ),
        padding: const EdgeInsets.only(top: 100),
        zoomGesturesEnabled: false,
        scrollGesturesEnabled: false,
        tiltGesturesEnabled: false,
        rotateGesturesEnabled: false,
        zoomControlsEnabled: false,
      ),
    );
  }
}
