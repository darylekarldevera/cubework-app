import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cubework_app_client/shared/modal/explore_search_widget.dart';

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
  void initState() {
    super.initState();
    // Set to fullscreen mode, hiding the bottom navigation bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    // Restore the system UI when the widget is disposed
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => ExploreSearchWidget(
                        searchBarCloseViewCallback: (String value) {
                      Navigator.of(context).pop();
                    }));
          },
          child: const ListTile(
            leading: Icon(Icons.search),
            title: Text("Search"),
          ),
        ),
      ),
    );
  }
}
