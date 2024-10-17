import 'package:flutter/material.dart';

class LocationResultsSlidingUpCollapse extends StatelessWidget {
  const LocationResultsSlidingUpCollapse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: Container(),
          title: const Icon(Icons.drag_handle),
          centerTitle: true,
          backgroundColor: Colors.grey[200],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
        ));
  }
}
