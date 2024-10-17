import 'package:flutter/material.dart';
import 'package:cubework_app_client/widgets/location_floating_warehouse_details_image_controllers.dart';

class LocationFloatingWarehouseDetailsImage extends StatelessWidget {
  final void Function() iconCloseHandler;
  final void Function() favoriteCloseHandler;
  const LocationFloatingWarehouseDetailsImage(
      {super.key,
      required this.iconCloseHandler,
      required this.favoriteCloseHandler});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: const Image(
            image: AssetImage('lib/assets/images/placeholder_vertical.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: LocationFloatingWarehouseDetailsImageControllers(
                iconHandler: iconCloseHandler, buttonIcon: Icons.close)),
        Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: LocationFloatingWarehouseDetailsImageControllers(
                iconHandler: favoriteCloseHandler,
                buttonIcon: Icons.favorite_outline)),
      ],
    );
  }
}
