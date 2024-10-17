import 'package:flutter/material.dart';

class WarehouseDetailsReserveButton extends StatelessWidget {
  final void Function() onTap;
  final String title;
  const WarehouseDetailsReserveButton(
      {super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    ));
  }
}
