import 'package:cubework_app_client/models/tag.dart';
import 'package:flutter/material.dart';

class WarehouseTags extends StatelessWidget {
  final Tag tags;
  const WarehouseTags({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40, // Set a fixed height for the ListView
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tags.label.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.lightBlue[50],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              tags.label[index],
              style: const TextStyle(color: Colors.blue),
            ),
          );
        },
      ),
    );
  }
}
