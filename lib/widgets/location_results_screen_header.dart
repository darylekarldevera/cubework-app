import 'package:flutter/material.dart';
import 'package:cubework_app_client/utils/format_date.dart';
import 'package:cubework_app_client/interfaces/reserved_warehouse.dart';

import 'package:cubework_app_client/shared/components/slide_bar_button_list.dart';
import 'package:cubework_app_client/shared/modal/explore_search_widget.dart';

class LocationResultsScreenHeader extends StatelessWidget {
  final ReservedWarehouse reservedWarehouse;
  
  const LocationResultsScreenHeader(
      {super.key, required this.reservedWarehouse});

  String formatString(DateTime date, String time, String meridiem) {
    final formattedDate = formatDate(date);
    return "$formattedDate, $time $meridiem";
  }

  Function() get searchButtonTitleHandler => () {
        final startDate = reservedWarehouse.startDate;
        final endDate = reservedWarehouse.endDate;

        if (endDate.date == null && startDate.date != null) {
          final formattedStartDate = formatString(
              startDate.date!, startDate.time!, startDate.meridiem!);

          return "$formattedStartDate - $formattedStartDate";
        }

        if (startDate.date != null && endDate.date != null) {
          final formattedStartDate = formatString(
              startDate.date!, startDate.time!, startDate.meridiem!);

          final formattedEndDate = formatString(
              startDate.date!, startDate.time!, startDate.meridiem!);

          return "$formattedStartDate - $formattedEndDate";
        }

        return "No date selected";
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 15.0),
              constraints: const BoxConstraints(maxHeight: double.infinity),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        leading: const Icon(Icons.search),
                        title: Text(
                          reservedWarehouse.warehouse.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          searchButtonTitleHandler(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () => {
                            print("Filter button pressed"),
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Icon(
                              Icons.tune,
                            ),
                          ),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                ExploreSearchWidget(
                              searchBarCloseViewCallback: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Container(height: 15),
                    const SlideBarButtonList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
