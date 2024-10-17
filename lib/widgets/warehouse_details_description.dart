import 'package:flutter/material.dart';

class WarehouseDetailsDescription extends StatefulWidget {
  final String description;
  const WarehouseDetailsDescription({super.key, required this.description});

  @override
  State<WarehouseDetailsDescription> createState() =>
      _WarehouseDetailsDescriptionState();
}

class _WarehouseDetailsDescriptionState
    extends State<WarehouseDetailsDescription> {
  bool isShowMoreDescription = false;

  String getDescription() {
    if (isShowMoreDescription) {
      return widget.description;
    }

    return "${widget.description.substring(0, 50)}...";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Description",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(getDescription()),
          GestureDetector(
            onTap: () => {
              setState(() {
                isShowMoreDescription = !isShowMoreDescription;
              })
            },
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                // Ensures the row takes up the minimum space needed
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isShowMoreDescription ? "Show less" : "Show all",
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    isShowMoreDescription
                        ? Icons.arrow_drop_up_sharp
                        : Icons.arrow_drop_down_sharp,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
