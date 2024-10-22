import 'package:cubework_app_client/constants/time_slots.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:cubework_app_client/utils/format_date.dart';

class DatePickerWidget extends StatefulWidget {
  final void Function(DateTime, String, String) datePickerHandler;
  const DatePickerWidget({super.key, required this.datePickerHandler});

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();

  // Static method to show the modal
  static void show(BuildContext context,
      void Function(DateTime, String, String) datePickerHandler) {
    // Show the stateful widget here
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DatePickerWidget(
          datePickerHandler: datePickerHandler,
        );
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

    selectedMeridiemIndicator = DateFormat('a').format(selectedDate);

    availableTimes = generateAvailableTimes(selectedDate);
    selectedTime = availableTimes.isNotEmpty ? availableTimes.first : "";

    dropDownFocus.addListener(() {
      setState(() {
        appBarTitle = dropDownFocus.hasFocus
            ? "Choose Reserve Time"
            : "Choose Pickup Time";
      });
    });
  }

  List<String> generateAvailableTimes(DateTime newDate) {
    List<String> times = [];
    DateTime currentTime = DateTime.now();

    // If the date is in the future, return all slots
    if (currentTime.day.compareTo(newDate.day) == -1) {
      if (selectedMeridiemIndicator == "PM" && todayMeridiemIndicator == "AM") {
        return pmTimeSlots;
      } else {
        return amTimeSlots;
      }
    }

    // Handle AM time slots
    if (selectedMeridiemIndicator == "AM" && todayMeridiemIndicator == "AM") {
      return amTimeSlots.asMap().entries.map((entry) {
        final timeParts = entry.value.split(":");
        final timeMinute = int.parse(timeParts[1]);
        int timeHour = int.parse(timeParts[0]);

        return timeSlot(entry, currentTime, timeHour, timeMinute);
      }).toList();
    }

    // Handle PM time slots
    if (selectedMeridiemIndicator == "PM" && todayMeridiemIndicator == "PM") {
      return pmTimeSlots.asMap().entries.map((entry) {
        final timeParts = entry.value.split(":");
        final timeMinute = int.parse(timeParts[1]);
        int timeHour = int.parse(timeParts[0]);

        timeHour += 12;

        if (timeHour == 24) {
          timeHour = 12;
        }

        return timeSlot(entry, currentTime, timeHour, timeMinute);
      }).toList();
    }

    // Return all PM slots if switching from AM to PM
    if (selectedMeridiemIndicator == "PM" && todayMeridiemIndicator == "AM") {
      return pmTimeSlots;
    }

    return times;
  }

  String timeSlot(MapEntry<int, String> entry, DateTime currentTime,
      int timeHour, int timeMinute) {
    if (timeHour > currentTime.hour) {
      return entry.value;
    } else if (timeHour == currentTime.hour &&
        timeMinute > currentTime.minute) {
      return entry.value;
    }

    return entry.value;
  }

  void onDateChangedHandler(DateTime date) {
    final formattedDate = formatDate(date);
    final formattedTodaysDate = formatDate(DateTime.now());
    final isTodaySelectedDate = formattedDate == formattedTodaysDate;
    final newDate = isTodaySelectedDate ? DateTime.now() : date;

    setState(() {
      todayMeridiemIndicator = DateFormat('a').format(DateTime.now());
      selectedMeridiemIndicator = DateFormat('a').format(newDate);

      selectedDate = newDate;
      availableTimes = generateAvailableTimes(newDate);
      selectedTime = availableTimes.isNotEmpty ? availableTimes.first : "";
    });
  }

  void meridiemIndicatorHandler(String indicator) {
    DateTime currentTime = DateTime.now();

    if (currentTime.day.compareTo(selectedDate.day) == 0 &&
        indicator == "AM" &&
        todayMeridiemIndicator == "PM") {
      return;
    }

    setState(() {
      selectedMeridiemIndicator = indicator;
      availableTimes = generateAvailableTimes(selectedDate);
      selectedTime = availableTimes.isNotEmpty ? availableTimes.first : "";
    });
  }

  Color isMeridiemIndicatorAvailable() {
    if (todayMeridiemIndicator == "PM") {
      return Colors.grey;
    }

    if (selectedMeridiemIndicator == "AM") {
      return Colors.white;
    }

    return Colors.black;
  }

  bool isSelectButtonEnabled() {
    if (availableTimes.isEmpty) {
      return false;
    }
    return true;
  }

  List<DropdownMenuItem<String>> getDropDownMenu() {
    // Check if availableTimes is null or empty
    if (availableTimes.isEmpty) {
      return [];
    }

    // Ensure unique values in the dropdown menu
    final uniqueTimes = availableTimes.toSet().toList();

    // Create the dropdown items
    return uniqueTimes.map<DropdownMenuItem<String>>((String time) {
      return DropdownMenuItem<String>(
        value: time,
        child: Text(time),
      );
    }).toList();
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
                    onDateChanged: (DateTime date) =>
                        onDateChangedHandler(date),
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
                                            items: getDropDownMenu())),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                meridiemIndicatorHandler("AM");
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 4),
                                color: selectedMeridiemIndicator != "AM"
                                    ? null
                                    : Colors.green,
                                child: Text("AM",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isMeridiemIndicatorAvailable())),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                meridiemIndicatorHandler("PM");
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 4),
                                color: selectedMeridiemIndicator != "PM"
                                    ? null
                                    : Colors.green,
                                child: Text("PM",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: selectedMeridiemIndicator == "PM"
                                            ? Colors.white
                                            : Colors.black)),
                              ),
                            ),
                          ],
                        ),
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
                            widget.datePickerHandler(selectedDate, selectedTime,
                                selectedMeridiemIndicator),
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
