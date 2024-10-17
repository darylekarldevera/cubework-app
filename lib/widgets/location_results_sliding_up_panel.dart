import 'package:flutter/material.dart';

class LocationResultsSlidingUpPanel extends StatelessWidget {
  const LocationResultsSlidingUpPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: const Center(
        child: Text(
          "This is the panel",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
