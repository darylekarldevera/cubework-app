import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cubework_app_client/services/fetch_location.dart';
import 'package:cubework_app_client/interfaces/reserved_location.dart';
import 'package:cubework_app_client/utils/serializable/locations.dart'
    as locations;

class LocationResultsScreen extends StatefulWidget {
  final ReservedPlace reservedPlace;
  // final 
  const LocationResultsScreen({super.key, required this.reservedPlace});

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
    cameraPosition =
        LatLng(widget.reservedPlace.office!.lat, widget.reservedPlace.office!.lng);
  }

  Map<String, Marker> assignMapMarkers(
      List<locations.Office> offices, locations.Office reservedPlace) {
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
        icon: office.name == reservedPlace.name
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
            : BitmapDescriptor.defaultMarker,
      );
      _markers[office.name] = marker;
    }
    return _markers;
  }

  void assignActiveMarker(locations.Office office) {
    Future.delayed(const Duration(milliseconds: 500), () {
      mapController.showMarkerInfoWindow(MarkerId(office.name));
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    // ignore: no_leading_underscores_for_local_identifiers
    void _onMapCreated(GoogleMapController controller) async {
      mapController = controller;
      // need to use then chains to ensure that the markers are being set
      // otherwise the markers will not be set in time (bug)
      await fetchLocation()
        .then((offices) {
          setState(() {
            markers.clear();
            markers = assignMapMarkers(offices, widget.reservedPlace.office!);
          });
        }).then((_) {
          assignActiveMarker(widget.reservedPlace.office!);
        });
    }

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text(widget.reservedPlace.office!.name),
      ),
      body: SlidingUpPanel(
        renderPanelSheet: false,
        // panel section
        panel: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10.0,
                spreadRadius: 5.0,
                offset: Offset(0.0, 0.0),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              "This is the collapsed Widget",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        // collapsed section
        collapsed: Container(
          decoration: const BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0)),
          ),
          child: const Center(
            child: Text(
              "This is the collapsed Widget",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        // map section
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: Set<Marker>.of(markers.values.toSet()),
          initialCameraPosition:
              CameraPosition(target: cameraPosition, zoom: 15),
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.62,
              bottom: MediaQuery.of(context).size.height * 0.20),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
        ),
      ),
    );
  }
}