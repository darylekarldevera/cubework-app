import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cubework_app_client/widgets/explore_screen_banner.dart';
import 'package:cubework_app_client/widgets/explore_screen_space_list.dart';
import 'package:cubework_app_client/shared/modal/explore_search_widget.dart';
import 'package:cubework_app_client/shared/components/slide_bar_button_list.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  void _searchBarCloseViewCallback() {
    Navigator.of(context).pop();
  }

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
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => ExploreSearchWidget(
                    searchBarCloseViewCallback: _searchBarCloseViewCallback,
                  ),
                );
              },
              child: const ListTile(
                leading: Icon(Icons.search),
                title: Text("Search"),
              ),
            ),
          ),
          // Image Banner Section
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.only(bottom: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: const Column(
              children: [
                ExploreScreenBanner(),
                SlideBarButtonList(),
              ],
            ),
          ),
          // Spaces Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Spaces",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                ExploreScreenSpaceList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
