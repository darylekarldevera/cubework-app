import 'package:flutter/material.dart';

class SearchModal extends StatefulWidget {
  final void Function(String) searchBarCloseViewCallback;
  const SearchModal({super.key, required this.searchBarCloseViewCallback});

  @override
  State<SearchModal> createState() => _SearchModalState();

  // Static method to show the modal
  static void show(
      BuildContext context, void Function(String) searchBarCloseViewCallback) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Makes it full screen
      builder: (context) {
        return SearchModal(
          searchBarCloseViewCallback: searchBarCloseViewCallback,
        ); // Show the stateful widget here
      },
    );
  }
}

class _SearchModalState extends State<SearchModal> {
  List<String> items = List.generate(5, (int index) => 'Item $index');
  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = items; // Initially, all items are shown
  }

  void setItems(String searchText) {
    setState(() {
      filteredItems = items
          .where(
              (item) => item.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 200, // Full height minus 200
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (text) {
                setItems(text); // Update filtered items based on search input
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredItems[index]),
                    onTap: () {
                      // Invoke the searchBarCloseViewCallback with the selected item
                      widget.searchBarCloseViewCallback(filteredItems[index]);
                      // Close the modal
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
