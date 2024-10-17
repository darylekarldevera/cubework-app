import 'package:flutter/material.dart';

import 'package:cubework_app_client/utils/object_keys.dart';
import 'package:cubework_app_client/utils/camel_to_sentence.dart';
import 'package:cubework_app_client/constants/warehouse_amenities_icons.dart';

import 'package:cubework_app_client/models/amenities.dart';

class WarehouseDetailsAmenities extends StatefulWidget {
  final Amenities amenities;
  const WarehouseDetailsAmenities({super.key, required this.amenities});

  @override
  State<WarehouseDetailsAmenities> createState() =>
      widgetDetailsAmenitiesState();
}

class widgetDetailsAmenitiesState extends State<WarehouseDetailsAmenities> {
  bool isShowMoreAmenities = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Amenities",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          // Property details
          ...objectKeys(widget.amenities).asMap().entries.map((entry) {
            final int index = entry.key;
            final key = entry.value;

            // Show only 5 items if show more is not clicked
            // if the value is false, return none
            if (!isShowMoreAmenities && index > 4 ||
                widget.amenities.toJson()[key] == false) {
              return Container();
            }

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    amenityIcons[key],
                  ),
                  const SizedBox(width: 15),
                  Text(camelToSentence(key.toString())),
                ],
              ),
            );
          }),
          GestureDetector(
            onTap: () => {
              setState(() {
                isShowMoreAmenities = !isShowMoreAmenities;
              })
            },
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                // Ensures the row takes up the minimum space needed
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isShowMoreAmenities ? "Show less" : "Show all",
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Icon(
                    isShowMoreAmenities
                        ? Icons.arrow_drop_up_sharp
                        : Icons.arrow_drop_down_sharp,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
