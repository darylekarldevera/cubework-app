import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cubework_app_client/services/fetch_location.dart';
import 'package:cubework_app_client/utils/serializable/locations.dart'
    as locations;

class LocationResultsScreen extends StatefulWidget {
  final locations.Office searchedOffice;
  const LocationResultsScreen({super.key, required this.searchedOffice});

  @override
  State<LocationResultsScreen> createState() => _LocationResultsScreenState();
}

class _LocationResultsScreenState extends State<LocationResultsScreen> {
  late LatLng cameraPosition;
  late Map<String, Marker> markers;
  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    markers = {};
    cameraPosition = LatLng(widget.searchedOffice.lat, widget.searchedOffice.lng);
  }

  Map<String, Marker> assignMapMarkers(List<locations.Office> offices, locations.Office searchedOffice) {
    // ignore: no_leading_underscores_for_local_identifiers
    final Map<String, Marker> _markers = {};

    for (final office in offices) {
      final marker = Marker(
        markerId: MarkerId(office.name),
        position: LatLng(office.lat, office.lng),
        infoWindow: InfoWindow(
          title: office.name,
          snippet: office.address,
        ),
        consumeTapEvents: true,
        icon: office.name == searchedOffice.name
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
            : BitmapDescriptor.defaultMarker,
      );
      _markers[office.name] = marker;
    }
    return _markers;
  }

  void assignActiveMarker(locations.Office office) {
    Future.delayed(const Duration(milliseconds: 300), () {
      mapController.showMarkerInfoWindow(MarkerId(office.name));
    });
  }

  @override
  Widget build(BuildContext context,) {
    // ignore: no_leading_underscores_for_local_identifiers
    void _onMapCreated(GoogleMapController controller) async {
      mapController = controller;
      final List<locations.Office> offices = await fetchLocation();

      setState(() {
        markers.clear();
        markers = assignMapMarkers(offices, widget.searchedOffice);
        assignActiveMarker(widget.searchedOffice);
      });
    }

    return GoogleMap(
      onMapCreated: _onMapCreated,
      markers: Set<Marker>.of(markers.values.toSet()),
      initialCameraPosition: CameraPosition(target: cameraPosition, zoom: 15),
    );
  }
}
