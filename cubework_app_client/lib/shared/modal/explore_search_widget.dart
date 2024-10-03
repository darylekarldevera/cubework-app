import 'package:flutter/material.dart';
import 'package:cubework_app_client/shared/modal/search_modal.dart';

class ExploreSearchWidget extends StatelessWidget {
  final void Function(String) searchBarCloseViewCallback;
  ExploreSearchWidget({super.key, required this.searchBarCloseViewCallback});

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

  @override
  Widget build(BuildContext context) {
    const double fortyPercentWidth = 0.4;
    const double sixPercentHeight = 0.06;
    final mediaQuery = MediaQuery.of(context);
    final mediaQueryWidth = mediaQuery.size.width * fortyPercentWidth;
    final mediaQueryHeight = mediaQuery.size.height * sixPercentHeight;

    return SafeArea(
      top: false, // Disable top SafeArea padding if not needed
      bottom: false, // Disable bottom SafeArea padding
      child: Container(
        alignment: Alignment.topCenter,
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Search", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
                    selectedColor: Colors.grey[300],
                    hoverColor: Colors.grey[300],
                    leading: Icon(btn["icon"]),
                    title: Text(btn['textField']),
                    onTap: () {
                      if (btn['textField'] == "Location") {
                        SearchModal.show(
                          context,
                          searchBarCloseViewCallback,
                        );
                      }
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
