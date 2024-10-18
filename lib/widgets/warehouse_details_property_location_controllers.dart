import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cubework_app_client/models/location.dart';

class WarehouseDetailsPropertyLocationControllers extends StatelessWidget {
  final Location location;
  const WarehouseDetailsPropertyLocationControllers(
      {super.key, required this.location});

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
        Text(location.address),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildButton(
              title: "Direction",
              icon: Icons.directions,
              onTap: () {
                // Handle Direction button tap
                print('Direction button tapped');
              },
            ),
            const SizedBox(width: 20),
            buildButton(
              title: "Copy",
              icon: Icons.copy,
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: location.address));
                const snackBar = SnackBar(
                  content: Text('Copied to Clipboard', textAlign: TextAlign.center),
                    duration: Duration(seconds: 1, milliseconds: 5),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        )
      ],
    );
  }
}
