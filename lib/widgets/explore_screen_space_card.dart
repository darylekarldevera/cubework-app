import 'package:flutter/material.dart';
import 'package:cubework_app_client/models/warehouse.dart';
import 'package:cubework_app_client/widgets/explore_screen_space_card_image.dart';

class ExploreScreenSpaceCard extends StatelessWidget {
  final Warehouse space;
  const ExploreScreenSpaceCard({super.key, required this.space});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.30,
            width: double.infinity,
            child: ExploreScreenSpaceCardImage(images: space.images),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "\$${space.price.currentPrice}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8), // Add space here
                  Text(
                    "\$${space.price.originalPrice}",
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
                  Text("${space.rating.stars}",
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
            child: Text("${space.price.discount}% OFF",
                style: const TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }
}
