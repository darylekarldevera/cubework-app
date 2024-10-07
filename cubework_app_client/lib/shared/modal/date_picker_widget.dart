import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cubework_app_client/utils/format_date.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

class DatePickerWidget extends StatefulWidget {
  final void Function(DateTime, String) datePickerHandler;
  const DatePickerWidget({super.key, required this.datePickerHandler});

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();

  // Static method to show the modal
  static void show(
      BuildContext context, void Function(DateTime, String) datePickerHandler) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DatePickerWidget(
          datePickerHandler: datePickerHandler,
        ); // Show the stateful widget here
      },
    );
  }
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  late DateTime selectedDate;
  late List<String> availableTimes;
  late String selectedTime;
  late String appBarTitle = "Choose Pickup Time";

  late String todayMeridiemIndicator = DateFormat('a').format(DateTime.now());
  late String selectedMeridiemIndicator;
  final FocusNode dropDownFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    generateAvailableTimes(selectedDate);

    selectedTime = availableTimes.isNotEmpty
        ? availableTimes.first
        : DateFormat.Hm().format(DateTime.now());

    selectedMeridiemIndicator = DateFormat('a').format(selectedDate);

    dropDownFocus.addListener(() {
      setState(() {
        appBarTitle = dropDownFocus.hasFocus
            ? "Choose Reserve Time"
            : "Choose Pickup Time";
      });
    });
  }

  void generateAvailableTimes(DateTime newDate) {
    DateTime currentTime;
    final endOfDay = DateTime(newDate.year, newDate.month, newDate.day, 23, 59);

    // If the time is before 30 minutes in the hour, round to the next half hour
    // If the time is after 30 minutes, round up to 1:30 of the next hour
    if (newDate.minute < 30) {
      currentTime =
          DateTime(newDate.year, newDate.month, newDate.day, newDate.hour, 30);
    } else {
      // Move to the next hour and start at 30 minutes past that hour
      currentTime = DateTime(
          newDate.year, newDate.month, newDate.day, newDate.hour + 1, 30);
    }

    List<String> times = [];

    // Generate time slots with 30-minute gaps until end of the day
    while (currentTime.isBefore(endOfDay)) {
      times.add(DateFormat.Hm()
          .format(currentTime)); // Convert time to 12-hour format
      currentTime = currentTime
          .add(const Duration(minutes: 30)); // Increment by 30 minutes
    }

    setState(() {
      availableTimes = times;
    });
  }

  void onDateChangedHandler(DateTime date) {
    final formattedDate = formatDate(date);
    final formattedTodaysDate = formatDate(DateTime.now());
    final isTodaySelectedDate = formattedDate == formattedTodaysDate;
    final newDate = isTodaySelectedDate ? DateTime.now() : date;
    setState(() {
      selectedDate = newDate;
      generateAvailableTimes(newDate);
      todayMeridiemIndicator =
          isTodaySelectedDate ? DateFormat('a').format(DateTime.now()) : "AM";
    });
  }

  Color isMeridiemIndicatorAvailable() {
    if (todayMeridiemIndicator == "PM") {
      return Colors.grey;
    }
    return Colors.black;
  }

  bool isSelectButtonEnabled() {
    if (availableTimes.isNotEmpty &&
        availableTimes.first == selectedTime) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Scaffold(
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            title: Container(
              margin: const EdgeInsets.only(top: 6),
              alignment: Alignment.topLeft,
              child: Text(appBarTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            automaticallyImplyLeading:
                false, // Prevents the default leading (back arrow) from appearing
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  backgroundColor: Colors
                      .grey.shade300, // Background color inside the circle
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                    color: Colors.white, // Color of the icon itself
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Theme(
                  data: ThemeData(
                    colorScheme: const ColorScheme.light(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                      surface: Colors.white,
                      onSurface: Colors.black,
                    ),
                    dialogBackgroundColor: Colors.white,
                  ),
                  child: CalendarDatePicker(
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    onDateChanged: (DateTime date) => onDateChangedHandler(date),
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Text("Time",
                                    style: TextStyle(fontSize: 16)),
                                Container(
                                    margin: const EdgeInsets.all(10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade100,
                                    ),
                                    child: availableTimes.isEmpty
                                        ? const Text(
                                            "No available times",
                                            style: TextStyle(fontSize: 16),
                                          )
                                        : DropdownButton2<String>(
                                            focusNode: dropDownFocus,
                                            isDense: true,
                                            iconStyleData: IconStyleData(
                                              icon: Container(),
                                            ),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                            dropdownStyleData:
                                                DropdownStyleData(
                                                    offset: Offset(
                                                        0,
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            -0.025),
                                                    maxHeight:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.18,
                                                    width: double.infinity),
                                            value: selectedTime,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                if (newValue != null) {
                                                  selectedTime = newValue;
                                                }
                                              });
                                            },
                                            items: availableTimes.isNotEmpty
                                                ? availableTimes.map<
                                                    DropdownMenuItem<
                                                        String>>((String time) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: time,
                                                      child: Text(time),
                                                    );
                                                  }).toList()
                                                : [],
                                          )),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (todayMeridiemIndicator == "PM") return;
                                    selectedMeridiemIndicator = "AM";
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 4),
                                  color: selectedMeridiemIndicator != "AM"
                                      ? null
                                      : Colors.grey.shade100,
                                  child: Text("AM",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold, color: isMeridiemIndicatorAvailable())),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedMeridiemIndicator = "PM";
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 4),
                                  color: selectedMeridiemIndicator != "PM"
                                      ? null
                                      : Colors.grey.shade100,
                                  child: const Text("PM",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: ElevatedButton(
                      onPressed: () => {
                            widget.datePickerHandler(selectedDate, selectedTime),
                            Navigator.of(context).pop()
                          },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          isSelectButtonEnabled()
                              ? Colors.green
                              : Colors.grey.shade100,
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text("Select",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isSelectButtonEnabled()
                                    ? Colors.white
                                    : Colors.black)),
                      )))
            ],
          )),
    );
  }
}
