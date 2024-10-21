import 'package:flutter/material.dart';

class WarehouseDetailsControllers extends StatelessWidget {
  const WarehouseDetailsControllers({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.arrow_back),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => {},
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.share),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () => {},
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.favorite_outline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
