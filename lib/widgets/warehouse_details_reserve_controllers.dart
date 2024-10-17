import 'package:flutter/material.dart';
import 'package:cubework_app_client/widgets/warehouse_details_reserve_button.dart';

class WarehouseDetailsReserveControllers extends StatelessWidget {
  const WarehouseDetailsReserveControllers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WarehouseDetailsReserveButton(onTap: () => {}, title: "Start Date"),
            const SizedBox(width: 40),
            WarehouseDetailsReserveButton(onTap: () => {}, title: "End Date"),
          ],
        ),
        GestureDetector(
          onTap: () => {},
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.green, width: 1),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Reserve", style: TextStyle(color: Colors.green)),
                SizedBox(width: 5),
                Icon(Icons.arrow_drop_down_sharp, color: Colors.green),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
