import 'package:cubework_app_client/interfaces/reserved_warehouse.dart';
import 'package:flutter/material.dart';

class WarehouseReserveModal extends StatefulWidget {
  const WarehouseReserveModal({super.key});

  @override
  State<WarehouseReserveModal> createState() => _WarehouseReserveModalState();

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const WarehouseReserveModal();
      },
    );
  }
}

class _WarehouseReserveModalState extends State<WarehouseReserveModal> {
  DateTimeInfo? startDate;
  DateTimeInfo? endDate;

  Widget customButton(String title, Function() onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onTap,
        child: Text(title, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Make a Reservation",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            customButton("Reserve", () => {}),
            customButton("Reserve Event Space", () => {}),
          ],
        ),
      ),
    );
  }
}
