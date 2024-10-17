import 'package:cubework_app_client/utils/assign_active_marker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

import 'package:cubework_app_client/models/warehouse.dart';
import 'package:cubework_app_client/services/fetch_warehouse_locations.dart';

class LocationGoogleMaps extends StatefulWidget {
  final Warehouse reserveWarehouse;
  final void Function(Warehouse warehouses) tappedIconHandler;
  final void Function(List<Warehouse> warehouses) setWarehouseLength;

  const LocationGoogleMaps({
    super.key,
    required this.reserveWarehouse,
    required this.tappedIconHandler,
    required this.setWarehouseLength,
  });

  @override
  State<LocationGoogleMaps> createState() => _LocationGoogleMapsState();
}

class _LocationGoogleMapsState extends State<LocationGoogleMaps> {
  late LatLng cameraPosition;
  late Map<String, Marker> markers;
  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    _initializeMapRenderer();

    markers = {};
    cameraPosition = LatLng(widget.reserveWarehouse.location.lat,
        widget.reserveWarehouse.location.lng);
  }

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    // need to use then chains to ensure that the markers are being set
    // otherwise the markers will not be set in time (bug)
    await fetchWarehouseLocations().then((warehouses) {
      widget.setWarehouseLength(warehouses);
      
      setState(() {
        markers.clear();
        markers = assignMapMarkers(warehouses, widget.reserveWarehouse);
      });
    }).then((_) {
      assignActiveMarker(widget.reserveWarehouse, mapController);
    });
  }

  Map<String, Marker> assignMapMarkers(
      List<Warehouse> warehouses, Warehouse reserveWarehouse) {
    final Map<String, Marker> _markers = {};

    for (final warehouse in warehouses) {
      final marker = Marker(
        markerId: MarkerId(warehouse.name),
        position: LatLng(warehouse.location.lat, warehouse.location.lng),
        infoWindow: InfoWindow(
          title: warehouse.name,
          snippet: warehouse.location.address,
        ),
        icon: warehouse.name == reserveWarehouse.name
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
            : BitmapDescriptor.defaultMarker,
        consumeTapEvents: false,
        onTap: () => {
          widget.tappedIconHandler(warehouse),
        },
      );
      _markers[warehouse.name] = marker;
    }
    return _markers;
  }

   // this is a workaround to fix the issue with the map not rendering on Android
  // error: 'updateAcquireFence: Did not find frame'
  void _initializeMapRenderer() {
    final GoogleMapsFlutterPlatform mapsImplementation =
        GoogleMapsFlutterPlatform.instance;
    if (mapsImplementation is GoogleMapsFlutterAndroid) {
      mapsImplementation.useAndroidViewSurface = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      markers: Set<Marker>.of(markers.values.toSet()),
      initialCameraPosition:
          CameraPosition(target: cameraPosition, zoom: 15),
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
    );
  }
}
