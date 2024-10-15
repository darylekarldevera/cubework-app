import 'package:cubework_app_client/screens/Location_results_screen.dart';
import 'package:cubework_app_client/utils/format_date.dart';
import 'package:flutter/material.dart';
import 'package:cubework_app_client/interfaces/reserved_warehouse.dart';
import 'package:cubework_app_client/utils/serializable/locations.dart';

import 'package:cubework_app_client/shared/modal/search_modal.dart';
import 'package:cubework_app_client/shared/modal/date_picker_widget.dart';

class ExploreSearchWidget extends StatefulWidget {
  final void Function() searchBarCloseViewCallback;
  const ExploreSearchWidget({
    super.key,
    required this.searchBarCloseViewCallback,
  });

  @override
  State<ExploreSearchWidget> createState() => _ExploreSearchWidgetState();
}

class _ExploreSearchWidgetState extends State<ExploreSearchWidget> {
  late ReservedWarehouse reservedWarehouse;

  @override
  void initState() {
    super.initState();
    reservedWarehouse = ReservedWarehouseImpl(
      warehouse: Warehouse(address: "", lat: 0, lng: 0, name: "", city: ""),
      startDate: DateTimeInfo(),
      endDate: DateTimeInfo(),
    );
  }

  void Function(Warehouse) get getReserveLocation => (Warehouse value) {
      setState(() {
        reservedWarehouse = ReservedWarehouseImpl(
            warehouse: value,
            startDate: DateTimeInfo(),
            endDate: DateTimeInfo());
      });
    };

  void Function(DateTime date, String time, String meridiem) get _startDateCallback =>
      (DateTime date, String time, String meridiem) {
        setState(() {
          reservedWarehouse = ReservedWarehouseImpl(
            warehouse: reservedWarehouse.warehouse,
            startDate: DateTimeInfo(date: date, time: time, meridiem: meridiem),
            endDate: DateTimeInfo()
          );
        });
      };

  void Function(DateTime date, String time, String meridiem) get _endDateCallBack =>
      (DateTime date, String time, String meridiem) {
        setState(() {
          reservedWarehouse = ReservedWarehouseImpl(
            warehouse: reservedWarehouse.warehouse,
            startDate: DateTimeInfo(
                date: reservedWarehouse.startDate.date,
                time: reservedWarehouse.startDate.time,
                meridiem: reservedWarehouse.startDate.meridiem),
            endDate: DateTimeInfo(date: date, time: time, meridiem: meridiem),
          );
        });
      };

  final List<Map<String, dynamic>> searchBtn = [
    {
      'icon': Icons.search,
      'textField': "Location",
    },
    {
      'icon': Icons.calendar_today,
      'textField': "Start Date",
    },
    {
      'icon': Icons.calendar_today,
      'textField': "End Date",
    },
  ];

  Function get _onSearch => (BuildContext context, String value) {
        if (value == "Location") {
          SearchModal.show(
            context,
            getReserveLocation,
          );
          return;
        }

        if (value == "Start Date") {
          DatePickerWidget.show(context, _startDateCallback);
          return;
        }

        if (value == "End Date") {
          DatePickerWidget.show(context, _endDateCallBack);
          return;
        }
      };

  Function(DateTime date, String time, String meridiem) formatString = (DateTime date, String time, String meridiem) {
    final formattedDate = formatDate(date);
    return "$formattedDate, $time $meridiem";
  };

  Function(String) get buttonTitleHandler => (String value) {
        final reservedWarehouse = this.reservedWarehouse;
        final startDate = reservedWarehouse.startDate;
        final endDate = reservedWarehouse.endDate;

        if (value == "Start Date" && startDate.date != null) {
          return formatString(
              startDate.date!, startDate.time!, startDate.meridiem!);
        }

        if (value == "End Date" &&
            endDate.date == null &&
            startDate.date != null) {
          return formatString(
              startDate.date!, startDate.time!, startDate.meridiem!);
        }

        if (value == "End Date" && endDate.date != null) {
          return formatString(endDate.date!, endDate.time!, endDate.meridiem!);
        }

        if (value == "Location" && reservedWarehouse.warehouse.name.isNotEmpty) {
          return reservedWarehouse.warehouse.name;
        }

        return value;
      };

  Function(String) get buttonColorHandler => (String value) {
        if (value == "Start Date" && reservedWarehouse.warehouse.name.isEmpty) {
          return Colors.grey.shade500;
        }

        if (value == "End Date" &&
            reservedWarehouse.startDate.date == null) {
          return Colors.grey.shade500;
        }

        return Colors.black;
      };

  Function(String) get disableButtonHandler => (String value) {
        if (value == "Start Date" && reservedWarehouse.warehouse.name.isEmpty) {
          return true;
        }

        if (value == "End Date" &&
            reservedWarehouse.startDate.date == null) {
          return true;
        }

        return false;
      };

  @override
  Widget build(BuildContext context) {
    const double fortyPercentWidth = 0.4;
    const double sixPercentHeight = 0.06;

    final mediaQuery = MediaQuery.of(context);
    final mediaQueryWidth = mediaQuery.size.width * fortyPercentWidth;
    final mediaQueryHeight = mediaQuery.size.height * sixPercentHeight;

    return SafeArea(
      top: false,
      bottom: false,
      child: Container(
        alignment: Alignment.topCenter,
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Search",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Column(
            children:
                List<Widget>.from(searchBtn.map((Map<String, dynamic> btn) {
              return Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ListTile(
                    leading: Icon(btn["icon"]),
                    title: Text(buttonTitleHandler(btn['textField']),
                        style: TextStyle(
                            color: buttonColorHandler(btn['textField']))),
                    onTap: () {
                      if (disableButtonHandler(btn['textField'])) return;
                      _onSearch(context, btn['textField']);
                    },
                  ),
                ),
              );
            })),
          ),
          persistentFooterButtons: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: mediaQueryWidth,
                  height: mediaQueryHeight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.white),
                      foregroundColor: WidgetStateProperty.all(Colors.green),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.green)),
                      ),
                    ),
                    onPressed: () {
                      print("Filter");
                    },
                    child: const Text("Filter"),
                  ),
                ),
                SizedBox(
                  width: mediaQueryWidth,
                  height: mediaQueryHeight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.green)),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        // ignore: unnecessary_null_comparison
                        if (reservedWarehouse.warehouse == null) {
                          return const Text("Please select a location");
                        } 
                        return LocationResultsScreen(
                            reserveWarehouse: reservedWarehouse);
                      }));
                    },
                    child: const Text("Search"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
