import 'package:cubework_app_client/shared/modal/search_modal.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<Map<String, dynamic>> searchBtn = [
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
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  backgroundColor:
                      const WidgetStatePropertyAll(Color(0xFFFFFFFF)),
                  controller: controller,
                  hintText: "Search text",
                  leading: const Icon(Icons.search),
                  trailing: const [Icon(Icons.filter_list_alt)],
                  onTap: () => {
                    controller.openView(),
                  },
                  onChanged: (value) => {
                    controller.openView(),
                  },
                );
              },
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                return List<Widget>.from(
                    searchBtn.map((Map<String, dynamic> btn) {
                  return Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors
                          .white, // Add the color to the Container for the background
                    ),
                    // ClipRRect ensures the ListTile will have rounded corners by clipping it to match the container's borderRadius
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ListTile(
                        selectedColor: Colors.grey[300],
                        hoverColor: Colors.grey[300],
                        leading: Icon(btn["icon"]),
                        title: Text(btn['textField']),
                        onTap: () {
                          void searchBarCloseViewCallback(String text) {
                            controller.closeView(text);
                          }

                          SearchModal.show(
                            context,
                            searchBarCloseViewCallback,
                          );
                        },
                      ),
                    ),
                  );
                }));
              },
            )));
  }
}
