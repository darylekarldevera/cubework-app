import 'package:cubework_app_client/utils/format_date.dart';
import 'package:flutter/material.dart';
import 'package:cubework_app_client/interfaces/reserved_warehouse.dart';

class DateConfirmation extends StatefulWidget {
  final DateTimeInfo startDate;
  final DateTimeInfo endDate;
  const DateConfirmation(
      {super.key, required this.startDate, required this.endDate});

  @override
  State<DateConfirmation> createState() => _DateConfirmationState();

  static void show(
      BuildContext context, DateTimeInfo startDate, DateTimeInfo endDate) {
    showDialog(
      context: context,
      builder: (context) {
        return DateConfirmation(
          startDate: startDate,
          endDate: endDate,
        );
      },
    );
  }
}

class _DateConfirmationState extends State<DateConfirmation> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Are you sure you want to confirm the dates"),
      insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 24.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min, // Ensures the dialog size is minimal
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Start Date: ${formatDate(widget.startDate.date!)}", style: const TextStyle(fontSize: 14)),
              Text("End Date: ${formatDate(widget.endDate.date!)}", style: const TextStyle(fontSize: 14)),
            ],
          ),
          const SizedBox(height: 20), // Add space between content and buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 50,
                width: 120,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: const Text("Cancel",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SizedBox(
                height: 50,
                width: 120,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: const Text("Confirm",
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
