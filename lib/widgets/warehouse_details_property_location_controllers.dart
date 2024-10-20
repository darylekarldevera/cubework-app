import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:cubework_app_client/utils/get_my_position.dart';
import 'package:cubework_app_client/models/warehouse.dart';
import 'package:cubework_app_client/shared/modal/notify_modal.dart';

class WarehouseDetailsPropertyLocationControllers extends StatefulWidget {
  final Warehouse warehouse;
  const WarehouseDetailsPropertyLocationControllers(
      {super.key, required this.warehouse});

  @override
  State<WarehouseDetailsPropertyLocationControllers> createState() =>
      _WarehouseDetailsPropertyLocationControllersState();
}

class _WarehouseDetailsPropertyLocationControllersState
    extends State<WarehouseDetailsPropertyLocationControllers> {
  late bool isLoading;
  late bool isError;
  late String myOrigin;
  late Position? currentPosition;

  @override
  void initState() {
    super.initState();
    isError = false;
    isLoading = false;
    fetchCurrentPosition();
  }

  void Function() loading() {
    return () {
      setState(() {
        isLoading = !isLoading;
      });
    };
  }

  void fetchCurrentPosition() async {
    try {
      loading();
      currentPosition = await getMyPosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition!.latitude, currentPosition!.longitude);
      myOrigin = placemarks[0].name.toString();
      print('Current position: $placemarks');
    } catch (e) {
      loading();
      setState(() { isError = !isError; });
      print('Error fetching current position: $e');
    }
  }
  
  Future<void> navigateTo() async {
    if (currentPosition == null) {
      return;
    }

    final String origin =
        '${currentPosition!.latitude},${currentPosition!.longitude}';
    final String destination =
        '${widget.warehouse.location.lat},${widget.warehouse.location.lng}';

    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&origin=$origin&destination=$destination&travelmode=walking',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }


  Widget buildButton({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Expanded(
        child: GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.green, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.green),
            const SizedBox(width: 5),
            Text(title, style: const TextStyle(color: Colors.green)),
          ],
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Property Location",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(widget.warehouse.location.address),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildButton(
              title: "Direction",
              icon: Icons.directions,
              onTap: () {
                if (isLoading) {
                  NotifyModal.show(
                    context,
                    'Loading your location',
                    'Please wait a moment',
                    'Okay',
                    () {
                      Navigator.of(context).pop(); // Dismiss the dialog
                    },
                  );
                  return;
                }

                if (isError) {
                  NotifyModal.show(
                    context,
                    'Error fetching your location',
                    'Please try again',
                    'Okay',
                    () {
                      Navigator.of(context).pop(); // Dismiss the dialog
                    },
                  );
                  return;
                }
                navigateTo();
              },

            ),
            const SizedBox(width: 20),
            buildButton(
              title: "Copy",
              icon: Icons.copy,
              onTap: () async {
                await Clipboard.setData(
                    ClipboardData(text: widget.warehouse.location.address));
                const snackBar = SnackBar(
                  content:
                      Text('Copied to Clipboard', textAlign: TextAlign.center),
                  duration: Duration(seconds: 1, milliseconds: 5),
                );
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        )
      ],
    );
  }
}
