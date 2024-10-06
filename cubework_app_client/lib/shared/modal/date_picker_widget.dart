import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({super.key});

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();

  // Static method to show the modal
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, 
      builder: (context) {
        return const DatePickerWidget(); // Show the stateful widget here
      },
    );
  }
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  final now = DateTime.now();
  late DateTime selectedDate;
  late List<String> availableTimes;
  late String selectedTime;
  late String selectedMeridiemIndicator;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    generateAvailableTimes();
    selectedTime = availableTimes.first;
    selectedMeridiemIndicator = DateFormat('a').format(now);
  }

  void generateAvailableTimes() {
    DateTime currentTime;
    final endOfDay = DateTime(
        now.year, now.month, now.day, 23, 59);

    // If the time is before 30 minutes in the hour, round to the next half hour
    // If the time is after 30 minutes, round up to 1:30 of the next hour
    if (now.minute < 30) {
      currentTime = DateTime(now.year, now.month, now.day, now.hour, 30);
    } else {
      // Move to the next hour and start at 30 minutes past that hour
      currentTime = DateTime(now.year, now.month, now.day, now.hour + 1, 30);
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65, 
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
              // padding: const EdgeInsets.only(top: 16),
              alignment: Alignment.topLeft,
              child: const Text("Choose Pickup Time",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            automaticallyImplyLeading:
                false, // Prevents the default leading (back arrow) from appearing
            actions: [
              Padding(
                padding: const EdgeInsets.all(0),
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
                    onDateChanged: (DateTime date) {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                  ),
                ),
              ),
              Flexible(
                child: Container(
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
                                  child: DropdownButton<String>(
                                    isDense: true,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                    icon:
                                        Container(), // Hides the dropdown icon
                                    underline:
                                        Container(), // Removes the underline
                                    menuMaxHeight: 200,
                                    value: selectedTime,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedTime = newValue!;
                                      });
                                    },
                                    items: availableTimes
                                        .map<DropdownMenuItem<String>>(
                                            (String time) {
                                      return DropdownMenuItem<String>(
                                        value: time,
                                        child: Center(child: Text(time)),
                                      );
                                    }).toList(),
                                  ),
                                ),
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
                                    selectedMeridiemIndicator = "AM";
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 4),
                                  color: selectedMeridiemIndicator != "AM"
                                      ? null
                                      : Colors.grey.shade100,
                                  child: const Text("AM",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
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
              // change it into sizebox instead of container
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: ElevatedButton(
                      onPressed: () => {},
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Colors.grey.shade100,
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
                        child: const Text("Select",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                      ))
              )
            ],
          )),
    );
  }
}
