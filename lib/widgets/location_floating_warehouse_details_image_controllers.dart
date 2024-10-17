import 'package:flutter/material.dart';

class LocationFloatingWarehouseDetailsImageControllers extends StatelessWidget {
  final void Function() iconHandler;
  final IconData buttonIcon;
  const LocationFloatingWarehouseDetailsImageControllers(
      {super.key, required this.iconHandler, required this.buttonIcon});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Card(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: GestureDetector(
            onTap: iconHandler,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(buttonIcon, color: Colors.white),
            ),
          ),
        ));
  }
}
