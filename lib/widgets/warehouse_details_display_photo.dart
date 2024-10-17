import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WarehouseDetailsDisplayPhoto extends StatelessWidget {
  const WarehouseDetailsDisplayPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: CachedNetworkImage(
          imageUrl: 'https://via.placeholder.com/600x400/90EE90/ffffff',
          errorWidget: (context, url, error) => Image.asset(
              "lib/assets/images/placeholder_horizontal.jpg",
              fit: BoxFit.cover),
          placeholder: (context, url) =>
              Image.asset("lib/assets/images/placeholder_horizontal.jpg"),
          fit: BoxFit.cover),
    );
  }
}
