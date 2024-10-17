import 'package:flutter/material.dart';
import 'package:cubework_app_client/widgets/location_results_screen_header.dart';
import 'package:cubework_app_client/widgets/location_results_sliding_up_collapse.dart';
import 'package:cubework_app_client/widgets/location_results_sliding_up_panel.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:cubework_app_client/interfaces/reserved_warehouse.dart';

import 'package:cubework_app_client/models/warehouse.dart';
import 'package:cubework_app_client/widgets/location_google_maps.dart';
import 'package:cubework_app_client/widgets/location_floating_warehouse_details_card.dart';

class LocationResultsScreen extends StatefulWidget {
  final ReservedWarehouse reserveWarehouse;
  const LocationResultsScreen({super.key, required this.reserveWarehouse});

  @override
  State<LocationResultsScreen> createState() => _LocationResultsScreenState();
}

class _LocationResultsScreenState extends State<LocationResultsScreen> {
  int? warehouseLength = 0;
  late bool isMarkerTapped = true;
  late Warehouse tappedMarkerWarehouseDetails =
      widget.reserveWarehouse.warehouse;

  void setWarehouseLength(List<Warehouse> warehouses) {
    setState(() {
      warehouseLength = warehouses.length;
    });
  }

  void placeholderIconHandler() {
    setState(() {
      isMarkerTapped = !isMarkerTapped;
    });
  }

  void tappedIconMarkerHandler(Warehouse warehouse) {
    setState(() {
      isMarkerTapped = true;
      tappedMarkerWarehouseDetails = warehouse;
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: SlidingUpPanel(
          renderPanelSheet: false,
          panel: const LocationResultsSlidingUpPanel(),
          collapsed: const LocationResultsSlidingUpCollapse(),
          body: Column(
            children: [
              LocationResultsScreenHeader(
                  reservedWarehouse: widget.reserveWarehouse),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    LocationGoogleMaps(
                        reserveWarehouse: widget.reserveWarehouse.warehouse,
                        tappedIconHandler: tappedIconMarkerHandler,
                        setWarehouseLength: setWarehouseLength),
                    isMarkerTapped
                        ? LocationFloatingWarehouseDetails(
                            iconCloseHandler: placeholderIconHandler,
                            favoriteCloseHandler: placeholderIconHandler,
                            tappedMarkerWarehouseDetails:
                                tappedMarkerWarehouseDetails)
                        : Container(),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
