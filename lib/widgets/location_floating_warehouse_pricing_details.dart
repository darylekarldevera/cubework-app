import 'package:cubework_app_client/models/warehouse.dart';
import 'package:flutter/material.dart';

class LocationFloatingWarehousePricingDetails extends StatelessWidget {
  final Warehouse tappedMarkerWarehouseDetails;
  const LocationFloatingWarehousePricingDetails(
      {super.key, required this.tappedMarkerWarehouseDetails});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "\$2666.99",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8), // Add space here
                        Text(
                          "\$2745.69",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, size: 24),
                        Text('4.8', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.lightGreen[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text("40% OFF",
                      style: TextStyle(color: Colors.green)),
                ),
                Text(tappedMarkerWarehouseDetails.location.address),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text("Warehouse",
                      style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ),
        ));
  }
}
