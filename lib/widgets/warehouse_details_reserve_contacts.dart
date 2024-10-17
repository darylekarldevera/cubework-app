import 'package:flutter/material.dart';

class WarehouseDetailsReserveContacts extends StatelessWidget {
  const WarehouseDetailsReserveContacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(top: 15), child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Contact"),
          GestureDetector(
            onTap: () => {},
            child: Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.green, width: 1),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Send Message",
                      style: const TextStyle(color: Colors.green)),
                ],
              ),
            ),
          )
        ],
      ),);
  }
}