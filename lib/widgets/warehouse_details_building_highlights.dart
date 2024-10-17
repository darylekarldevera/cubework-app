import 'package:cubework_app_client/models/property_details.dart';
import 'package:cubework_app_client/utils/camel_to_sentence.dart';
import 'package:cubework_app_client/utils/object_keys.dart';
import 'package:flutter/material.dart';

class WarehouseDetailsBuildingHighlights extends StatefulWidget {
  final PropertyDetails propertyDetails;
  const WarehouseDetailsBuildingHighlights(
      {super.key, required this.propertyDetails});

  @override
  State<WarehouseDetailsBuildingHighlights> createState() =>
      _WarehouseDetailsBuildingHighlightsState();
}

class _WarehouseDetailsBuildingHighlightsState
    extends State<WarehouseDetailsBuildingHighlights> {
  bool isShowMorePropertyDetails = false;

  String getPropertyValue(dynamic key) {
    final value = widget.propertyDetails.toJson()[key];

    if (value is bool) {
      return value ? "Yes" : "No";
    }

    return value.toString();
  }

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
          const Text("Building Highlights",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          // Property details
          ...objectKeys(widget.propertyDetails).asMap().entries.map((entry) {
            final int index = entry.key;
            final key = entry.value;

            // Show only 5 items if show more is not clicked
            if (!isShowMorePropertyDetails && index > 4) {
              return Container();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(camelToSentence(key.toString())),
                Text(
                  getPropertyValue(key),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            );
          }),
          GestureDetector(
            onTap: () => {
              setState(() {
                isShowMorePropertyDetails = !isShowMorePropertyDetails;
              })
            },
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                // Ensures the row takes up the minimum space needed
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isShowMorePropertyDetails ? "Show less" : "Show all",
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    isShowMorePropertyDetails
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
