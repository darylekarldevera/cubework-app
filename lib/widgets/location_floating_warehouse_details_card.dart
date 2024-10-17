import 'package:flutter/material.dart';
import 'package:cubework_app_client/models/warehouse.dart';
import 'package:cubework_app_client/screens/warehouse_details_screen.dart';
import 'package:cubework_app_client/widgets/location_floating_warehouse_details_image.dart';
import 'package:cubework_app_client/widgets/location_floating_warehouse_pricing_details.dart';

class LocationFloatingWarehouseDetails extends StatefulWidget {
  final void Function() iconCloseHandler;
  final void Function() favoriteCloseHandler;
  final Warehouse tappedMarkerWarehouseDetails;

  const LocationFloatingWarehouseDetails(
      {super.key,
      required this.tappedMarkerWarehouseDetails,
      required this.iconCloseHandler,
      required this.favoriteCloseHandler});

  @override
  State<LocationFloatingWarehouseDetails> createState() =>
      _LocationFloatingWarehouseDetailsState();
}

class _LocationFloatingWarehouseDetailsState
    extends State<LocationFloatingWarehouseDetails> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: MediaQuery.of(context).size.height * 0.12,
        left: 0,
        right: 0,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return WarehouseDetailsScreen(
                  warehouse: widget.tappedMarkerWarehouseDetails);
            }));
          },
          child: Card(
            color: Colors.white,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.20,
              child: Row(
                children: [
                  LocationFloatingWarehouseDetailsImage(
                      iconCloseHandler: widget.iconCloseHandler,
                      favoriteCloseHandler: widget.favoriteCloseHandler),
                  LocationFloatingWarehousePricingDetails(
                      tappedMarkerWarehouseDetails:
                          widget.tappedMarkerWarehouseDetails),
                ],
              ),
            ),
          ),
        ));
  }
}
