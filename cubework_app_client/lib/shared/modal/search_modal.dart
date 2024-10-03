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
      height: MediaQuery.of(context).size.height - 100, // Full height minus 200
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
            padding: const EdgeInsets.only(top: 16),
            alignment: Alignment.topLeft,
            child: const Text("Search"),
          ),
          automaticallyImplyLeading:
              false, // Prevents the default leading (back arrow) from appearing
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 8.0),
              child: CircleAvatar(
                backgroundColor:
                    Colors.grey.shade300, // Background color inside the circle
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                width: double.infinity,
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                    hintText: "Where to go",
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (text) {
                    setItems(
                        text); // Update filtered items based on search input
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        filteredItems[index],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text("Placeholder Text"),
                      shape: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: Colors.grey.shade300,
                        ),
                      ),
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
      ),
    );
  }
}
