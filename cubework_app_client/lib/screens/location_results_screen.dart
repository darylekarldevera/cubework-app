import 'package:cubework_app_client/shared/components/slide_bar_button_list.dart';
import 'package:cubework_app_client/shared/modal/explore_search_widget.dart';
import 'package:cubework_app_client/utils/format_date.dart';
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
  int? officeLength = 0;
  late Map<String, Marker> markers;
  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    markers = {};
    cameraPosition = LatLng(
        widget.reservedPlace.office!.lat, widget.reservedPlace.office!.lng);
  }
  
  Map<String, Marker> assignMapMarkers(
      List<locations.Office> offices, locations.Office reservedPlace) {
    final Map<String, Marker> _markers = {};

    for (final office in offices) {
      final marker = Marker(
        markerId: MarkerId(office.name),
        position: LatLng(office.lat, office.lng),
        infoWindow: InfoWindow(
          title: office.name,
          snippet: office.address,
        ),
        icon: office.name == reservedPlace.name
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
            : BitmapDescriptor.defaultMarker,
        consumeTapEvents: false,
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

  Function(DateTime date, String time, String meridiem) formatString =
      (DateTime date, String time, String meridiem) {
    final formattedDate = formatDate(date);
    return "$formattedDate, $time $meridiem";
  };

  Function() get searchButtonTitleHandler => () {
        final reservedPlace = widget.reservedPlace;
        final startDate = reservedPlace.startDate;
        final endDate = reservedPlace.endDate;

        if (endDate.date == null && startDate.date != null) {
          final formattedStartDate = formatString(
              startDate.date!, startDate.time!, startDate.meridiem!);

          return "$formattedStartDate - $formattedStartDate";
        }

        if (startDate.date != null && endDate.date != null) {
          final formattedStartDate = formatString(
              startDate.date!, startDate.time!, startDate.meridiem!);

          final formattedEndDate = formatString(
              startDate.date!, startDate.time!, startDate.meridiem!);

          return "$formattedStartDate - $formattedEndDate";
        }

        return "No date selected";
      };

  @override
  Widget build(
    BuildContext context,
  ) {
    // ignore: no_leading_underscores_for_local_identifiers
    void _onMapCreated(GoogleMapController controller) async {
      mapController = controller;
      // need to use then chains to ensure that the markers are being set
      // otherwise the markers will not be set in time (bug)
      await fetchLocation().then((offices) {
        setState(() {
          markers.clear();
          officeLength = offices.length;
          markers = assignMapMarkers(offices, widget.reservedPlace.office!);
        });
      }).then((_) {
        assignActiveMarker(widget.reservedPlace.office!);
      });
    }

    return Scaffold(
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
            ),
            child: const Center(
              child: Text(
                "This is the panel",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          // collapsed section
            collapsed: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: Container(),
              title: const Icon(Icons.drag_handle),
              centerTitle: true,
              backgroundColor: Colors.grey[200],
              shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
              color: Colors.grey[200],
              ),
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
              child: Text(
                  "Over ${officeLength ?? 0} results",
                style: const TextStyle(color: Colors.black),
              ),
              ),
            ),
            ),
          // map section
          body: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: 10.0),
                        constraints:
                            const BoxConstraints(maxHeight: double.infinity),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey[200],
                                      elevation: 0),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          ExploreSearchWidget(
                                        searchBarCloseViewCallback: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.search),
                                        title: Text(
                                            widget.reservedPlace.office!.name),
                                        subtitle: Text(
                                          searchButtonTitleHandler(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(height: 15),
                              const SlideBarButtonList(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GoogleMap(
                onMapCreated: _onMapCreated,
                markers: Set<Marker>.of(markers.values.toSet()),
                initialCameraPosition:
                    CameraPosition(target: cameraPosition, zoom: 15),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                ),
              ),
            ],
          )),
    );
  }
}
