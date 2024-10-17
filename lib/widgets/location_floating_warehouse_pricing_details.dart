import 'package:flutter/material.dart';
import 'package:cubework_app_client/models/warehouse.dart';

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "\$${tappedMarkerWarehouseDetails.price.currentPrice}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8), // Add space here
                        Text(
                          "\$${tappedMarkerWarehouseDetails.price.originalPrice}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 24),
                        Text("${tappedMarkerWarehouseDetails.rating.stars}",
                            style: const TextStyle(fontSize: 16)),
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
                  child: Text(
                      "${tappedMarkerWarehouseDetails.price.discount}% OFF",
                      style: const TextStyle(color: Colors.green)),
                ),
                Text(tappedMarkerWarehouseDetails.location.address),
                SizedBox(
                  height: 40, // Set a fixed height for the ListView
                  child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tappedMarkerWarehouseDetails.tag.label.length,
                  itemBuilder: (context, index) {
                    return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[50],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tappedMarkerWarehouseDetails.tag.label[index],
                      style: const TextStyle(color: Colors.blue),
                    ),
                    );
                  },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
