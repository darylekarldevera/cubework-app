import 'package:flutter/material.dart';
import 'package:cubework_app_client/models/warehouse.dart';
import 'package:cubework_app_client/widgets/warehouse_details_property_location_controllers.dart';
import 'package:cubework_app_client/widgets/warehouse_details_property_location_maps.dart';

class WarehouseDetailsPropertyLocation extends StatelessWidget {
  final Warehouse warehouse;
  const WarehouseDetailsPropertyLocation({super.key, required this.warehouse});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey.shade300, width: 1),
              bottom: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
          ),
          child: Column(
            children: [
              WarehouseDetailsPropertyLocationControllers(
                  location: warehouse.location),
              WarehouseDetailsPropertyLocationMaps(warehouse: warehouse),
            ],
          ),
        )
      ],
    );
  }
}
