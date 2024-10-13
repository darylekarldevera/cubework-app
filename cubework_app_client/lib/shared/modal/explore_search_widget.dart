import 'package:cubework_app_client/screens/Location_results_screen.dart';
import 'package:cubework_app_client/utils/format_date.dart';
import 'package:flutter/material.dart';
import 'package:cubework_app_client/interfaces/reserved_location.dart';
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
  late ReservedPlace reservedPlace;

  @override
  void initState() {
    super.initState();
    reservedPlace = ReservedPlaceImpl(
      office: Office(address: "", lat: 0, lng: 0, name: "", city: ""),
      startDate: DateTimeInfo(),
      endDate: DateTimeInfo(),
    );
  }

  void Function(Office) get getReserveLocation => (Office value) {
      setState(() {
        reservedPlace = ReservedPlaceImpl(
            office: value,
            startDate: DateTimeInfo(),
            endDate: DateTimeInfo());
      });
    };

  void Function(DateTime date, String time, String meridiem) get _startDateCallback =>
      (DateTime date, String time, String meridiem) {
        setState(() {
          reservedPlace = ReservedPlaceImpl(
            office: reservedPlace.office,
            startDate: DateTimeInfo(date: date, time: time, meridiem: meridiem),
            endDate: DateTimeInfo()
          );
        });
      };

  void Function(DateTime date, String time, String meridiem) get _endDateCallBack =>
      (DateTime date, String time, String meridiem) {
        setState(() {
          reservedPlace = ReservedPlaceImpl(
            office: reservedPlace.office,
            startDate: DateTimeInfo(
                date: reservedPlace.startDate.date,
                time: reservedPlace.startDate.time,
                meridiem: reservedPlace.startDate.meridiem),
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
        final reservedPlace = this.reservedPlace;
        final startDate = reservedPlace.startDate;
        final endDate = reservedPlace.endDate;

        if (value == "Start Date" && startDate.date != null) {
          return formatString(startDate.date!, startDate.time!, startDate.meridiem!);
        }

        if (value == "End Date" &&
            endDate.date == null &&
            startDate.date != null) {
              
          return formatString(startDate.date!, startDate.time!, startDate.meridiem!);
        }

        if (value == "End Date" && endDate.date != null) {
          return formatString(endDate.date!, endDate.time!, endDate.meridiem!);
        }

        if (value == "Location" && reservedPlace.office!.name.isNotEmpty) {
          return reservedPlace.office?.name;
        }

        return value;
      };

  Function(String) get buttonColorHandler => (String value) {
        if (value == "Start Date" && reservedPlace.office!.name.isEmpty) {
          return Colors.grey.shade500;
        }

        if (value == "End Date" &&
            reservedPlace.startDate.date == null) {
          return Colors.grey.shade500;
        }

        return Colors.black;
      };

  Function(String) get disableButtonHandler => (String value) {
        if (value == "Start Date" && reservedPlace.office!.name.isEmpty) {
          return true;
        }

        if (value == "End Date" &&
            reservedPlace.startDate.date == null) {
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
                        if (reservedPlace.office == null) {
                          return const Text("Please select a location");
                        } 
                        return LocationResultsScreen(
                            reservedPlace: reservedPlace);
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
