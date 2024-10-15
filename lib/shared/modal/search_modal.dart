import 'package:flutter/material.dart';
import 'package:cubework_app_client/services/fetch_location.dart';
import 'package:cubework_app_client/utils/serializable/locations.dart';

class SearchModal extends StatefulWidget {
  final void Function(Warehouse) getLocationCallback;
  const SearchModal({super.key, required this.getLocationCallback});

  @override
  State<SearchModal> createState() => _SearchModalState();

  // Static method to show the modal
  static void show(
      BuildContext context, void Function(Warehouse) getLocationCallback) {
    showModalBottomSheet(
      context: context,
      // Makes it full screen
      isScrollControlled: true, 
      builder: (context) {
        return SearchModal(
          // Show the stateful widget here
          getLocationCallback: getLocationCallback,
        ); 
      },
    );
  }
}

class _SearchModalState extends State<SearchModal> {
  bool isLoading = true;
  List<Warehouse> items = [];
  List<Warehouse> filteredItems = [];

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Future.delayed(const Duration(seconds: 3));
    final data = await fetchLocation();
    setState(() {
      items = data;
      filteredItems = data;
      isLoading = false;
    });
  }

  void setItems(String searchText) {
    setState(() {
      filteredItems = items
          .where(
              (item) => item.city.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    
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
          // Prevents the default leading (back arrow) from appearing
          automaticallyImplyLeading:
              false, 
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 8.0),
              // Background color inside the circle
              child: CircleAvatar(
                backgroundColor:
                    Colors.grey.shade300,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                  color: Colors.white,
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
                    // Update filtered items based on search input
                    setItems(
                        text); 
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        filteredItems[index].name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(filteredItems[index].address),
                      shape: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      onTap: () {
                        // Invoke the getLocation with the selected item
                        widget.getLocationCallback(filteredItems[index]);
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
