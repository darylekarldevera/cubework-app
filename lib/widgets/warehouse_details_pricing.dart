import 'package:flutter/material.dart';
import 'package:cubework_app_client/models/warehouse.dart';
import 'package:cubework_app_client/shared/components/warehouse_tags.dart';

class WarehouseDetailsPricing extends StatelessWidget {
  final Warehouse warehouse;
  const WarehouseDetailsPricing({super.key, required this.warehouse});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              "\$${warehouse.price.currentPrice}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "\$${warehouse.price.originalPrice}",
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.lightGreen[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text("${warehouse.price.discount.round()}% OFF",
                  style: const TextStyle(color: Colors.green)),
            ),
          ],
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Listing Tile"),
            Text("Warehouse ID: 429",
                style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              const Icon(Icons.star, size: 24),
              Text('${warehouse.rating.stars}',
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 15),
          child: WarehouseTags(tags: warehouse.tag),
        ),
      ],
    );
  }
}
