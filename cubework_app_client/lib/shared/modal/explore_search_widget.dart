import 'package:flutter/material.dart';
import 'package:cubework_app_client/utils/format_date.dart';

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
  String? _startTime;
  String? _endTime;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _location;


  void Function(DateTime date, String time) get _startDateCallback => (DateTime date, String time) {
        setState(() {
          _startDate = date;
          _startTime = time;
        });
      };

  void Function(DateTime date, String time) get _endDateCallBack =>
      (DateTime date, String time) {
        setState(() {
          _endDate = date;
          _endTime = time;
        });
      };

  void Function(String) get getLocation => (String value) {
        setState(() {
          _location = value;
        });
      };

  @override
  void initState() {
    super.initState();
    _startDate = null;
    _endDate = null;
    _location = null;
  }

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
            getLocation,
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

  
  Function(String) get buttonTitleHandler => (String value) {
        if (value == "Start Date" && _startDate != null) {
          return '${formatDate(_startDate!)}, $_startTime';
        }

        if (value == "End Date" && _endDate == null && _startDate != null) {
          return '${formatDate(_startDate!)}, $_startTime';
        }

        if (value == "End Date" && _endDate != null) {
          return '${formatDate(_endDate!)}, $_endTime';
        }

        if (value == "Location" && _location != null) {
          return _location!;
        }

        return value;
      };

  Function(String) get buttonColorHandler => (String value) {
      if (value == "Start Date" && _location == null) {
        return Colors.grey.shade500;
      }   

      if (value == "End Date" && _startDate == null) {
        return Colors.grey.shade500;
      }

        return Colors.black;
      };

  Function(String) get disableButtonHandler => (String value) {
        if (value == "Start Date" && _location == null) {
          return true;
        }

        if (value == "End Date" && _startDate == null) {
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
                    title: Text(buttonTitleHandler(btn['textField']), style: TextStyle(color: buttonColorHandler(btn['textField']))),
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
                      print("Search");
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
