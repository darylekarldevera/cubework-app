import 'package:cubework_app_client/models/warehouse.dart';
import 'package:cubework_app_client/screens/warehouse_details_screen.dart';
import 'package:cubework_app_client/services/fetch_warehouse_locations.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cubework_app_client/interfaces/reserved_warehouse.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

import 'package:cubework_app_client/utils/format_date.dart';

import 'package:cubework_app_client/shared/components/slide_bar_button_list.dart';
import 'package:cubework_app_client/shared/modal/explore_search_widget.dart';

class LocationResultsScreen extends StatefulWidget {
  final ReservedWarehouse reserveWarehouse;
  const LocationResultsScreen({super.key, required this.reserveWarehouse});

  @override
  State<LocationResultsScreen> createState() => _LocationResultsScreenState();
}

class _LocationResultsScreenState extends State<LocationResultsScreen> {
  late LatLng cameraPosition;
  int? warehouseLength = 0;
  late Map<String, Marker> markers;
  late GoogleMapController mapController;
  late Warehouse tappedMarkerWarehouseDetails =
      widget.reserveWarehouse.warehouse;
  late bool isMarkerTapped = true;

  @override
  void initState() {
    super.initState();
    markers = {};
    cameraPosition = LatLng(widget.reserveWarehouse.warehouse.location.lat,
        widget.reserveWarehouse.warehouse.location.lng);

    _initializeMapRenderer();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
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
          setState(() {
            isMarkerTapped = true;
            tappedMarkerWarehouseDetails = warehouse;
          })
        },
      );
      _markers[warehouse.name] = marker;
    }
    return _markers;
  }

  void assignActiveMarker(Warehouse warehouse) {
    Future.delayed(const Duration(milliseconds: 500), () {
      mapController.showMarkerInfoWindow(MarkerId(warehouse.name));
    });
  }

  Function(DateTime date, String time, String meridiem) formatString =
      (DateTime date, String time, String meridiem) {
    final formattedDate = formatDate(date);
    return "$formattedDate, $time $meridiem";
  };

  Function() get searchButtonTitleHandler => () {
        final reserveWarehouse = widget.reserveWarehouse;
        final startDate = reserveWarehouse.startDate;
        final endDate = reserveWarehouse.endDate;

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
      await fetchWarehouseLocations().then((warehouses) {
        setState(() {
          markers.clear();
          warehouseLength = warehouses.length;
          markers =
              assignMapMarkers(warehouses, widget.reserveWarehouse.warehouse);
        });
      }).then((_) {
        assignActiveMarker(widget.reserveWarehouse.warehouse);
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
                  "Over ${warehouseLength ?? 0} results",
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
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
                                        title: Text(widget
                                            .reserveWarehouse.warehouse.name),
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
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    GoogleMap(
                      onMapCreated: _onMapCreated,
                      markers: Set<Marker>.of(markers.values.toSet()),
                      initialCameraPosition:
                          CameraPosition(target: cameraPosition, zoom: 15),
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                    ),
                    isMarkerTapped
                        ? Positioned(
                            bottom: MediaQuery.of(context).size.height * 0.12,
                            left: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return WarehouseDetailsScreen(warehouse: tappedMarkerWarehouseDetails);
                                }));
                              },
                              child: Card(
                                color: Colors.white,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.20,
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: const Image(
                                              image: AssetImage(
                                                  'lib/assets/images/placeholder_vertical.jpg'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            top: 10,
                                            left: 0,
                                            right: 0,
                                            child: Align(
                                                alignment: Alignment.topCenter,
                                                child: Card(
                                                  color: Colors.transparent,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        isMarkerTapped = false;
                                                      });
                                                    },
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      child: Icon(Icons.close,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                )),
                                          ),
                                          Positioned(
                                            bottom: 10,
                                            left: 0,
                                            right: 0,
                                            child: Align(
                                                alignment: Alignment.topCenter,
                                                child: Card(
                                                  color: Colors.transparent,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        isMarkerTapped = false;
                                                      });
                                                    },
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      child: Icon(
                                                          Icons
                                                              .favorite_outline,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "\$2666.99",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width:
                                                                  8), // Add space here
                                                          Text(
                                                            "\$2745.69",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(Icons.star,
                                                              size: 24),
                                                          Text('4.8',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: Colors
                                                          .lightGreen[100],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: const Text("40% OFF",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green)),
                                                  ),
                                                  Text(
                                                      tappedMarkerWarehouseDetails.location
                                                      .address),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.lightBlue[50],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: const Text(
                                                        "Warehouse",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.blue)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ))
                        : Container(),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
