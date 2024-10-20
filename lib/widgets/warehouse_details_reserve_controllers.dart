import 'package:flutter/material.dart';

import 'package:cubework_app_client/utils/format_date.dart';
import 'package:cubework_app_client/shared/modal/date_confirmation.dart';
import 'package:cubework_app_client/interfaces/reserved_warehouse.dart';
import 'package:cubework_app_client/shared/modal/date_picker_widget.dart';
import 'package:cubework_app_client/shared/modal/warehouse_reserve_modal.dart';
import 'package:cubework_app_client/widgets/warehouse_details_reserve_button.dart';

class WarehouseDetailsReserveControllers extends StatefulWidget {
  const WarehouseDetailsReserveControllers({super.key});

  @override
  State<WarehouseDetailsReserveControllers> createState() =>
      _WarehouseDetailsReserveControllersState();
}

class _WarehouseDetailsReserveControllersState
    extends State<WarehouseDetailsReserveControllers> {
  DateTimeInfo? startDate;
  DateTimeInfo? endDate;

  void Function(DateTime date, String formattedDate, String formattedTime)
      get startDateCallback =>
          (DateTime date, String formattedDate, String formattedTime) {
            setState(() {
              startDate = DateTimeInfo(date: date, time: formattedTime);
            });
          };

  void Function(DateTime date, String formattedDate, String formattedTime)
      get endDateCallback =>
          (DateTime date, String formattedDate, String formattedTime) {
            setState(() {
              endDate = DateTimeInfo(date: date, time: formattedTime);
            });
          };

  String getDateString(DateTimeInfo? selectedDate, String title) {
    if (selectedDate == null) {
      return title;
    }

    final String formattedDate = formatDate(selectedDate.date!);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WarehouseDetailsReserveButton(
              onTap: () => {DatePickerWidget.show(context, startDateCallback)},
              title: getDateString(startDate, "Start Date"),
            ),
            const SizedBox(width: 40),
            WarehouseDetailsReserveButton(
              onTap: () => {DatePickerWidget.show(context, endDateCallback)},
              title: getDateString(endDate, "End Date"),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => {
            if (startDate != null && endDate != null) {
              DateConfirmation.show(context, startDate!, endDate!)
            } else {
              WarehouseReserveModal.show(context)
            }
          },
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
