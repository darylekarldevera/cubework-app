import 'package:flutter/material.dart';

import 'package:cubework_app_client/models/warehouse.dart';

import 'package:cubework_app_client/widgets/warehouse_details_pricing.dart';
import 'package:cubework_app_client/widgets/warehouse_details_amenities.dart';
import 'package:cubework_app_client/widgets/warehouse_details_description.dart';
import 'package:cubework_app_client/widgets/warehouse_details_controllers.dart';
import 'package:cubework_app_client/widgets/warehouse_details_display_photo.dart';
import 'package:cubework_app_client/widgets/warehouse_details_building_highlights.dart';
import 'package:cubework_app_client/widgets/warehouse_details_reserve_controllers.dart';

class WarehouseDetailsScreen extends StatefulWidget {
  final Warehouse warehouse;
  const WarehouseDetailsScreen({super.key, required this.warehouse});

  @override
  State<WarehouseDetailsScreen> createState() => _WarehouseDetailsScreenState();
}

class _WarehouseDetailsScreenState extends State<WarehouseDetailsScreen> {
  late Warehouse _warehouse;
  bool isShowMoreAmenities = false;
  bool isShowMoreDescription = false;
  bool isShowMorePropertyDetails = false;

  @override
  initState() {
    super.initState();
    _warehouse = widget.warehouse;
  }

  String getDescription() {
    if (isShowMoreDescription) {
      return _warehouse.description;
    }

    return "${_warehouse.description.substring(0, 50)}...";
  }

  String getPropertyValue(dynamic key) {
    final value = _warehouse.propertyDetails.toJson()[key];

    if (value is bool) {
      return value ? "Yes" : "No";
    }

    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      const Stack(
        children: [
          WarehouseDetailsDisplayPhoto(),
          WarehouseDetailsControllers(),
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WarehouseDetailsPricing(warehouse: widget.warehouse),
            // Reserve controllers
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const WarehouseDetailsReserveControllers(),
                // Description
                WarehouseDetailsDescription(
                    description: widget.warehouse.description),
                // Building Highlights
                WarehouseDetailsBuildingHighlights(
                    propertyDetails: widget.warehouse.propertyDetails),
                // Amenities
                WarehouseDetailsAmenities(
                    amenities: widget.warehouse.amenities),
              ],
            )
          ],
        ),
      )
    ]));
  }
}
