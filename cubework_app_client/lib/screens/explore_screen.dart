import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cubework_app_client/shared/components/slide_bar_button_list.dart';
import 'package:cubework_app_client/shared/modal/explore_search_widget.dart';

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

  final List<Map<String, dynamic>> spaces = [
    {
      'image': "https://via.placeholder.com/600x400/90EE90/ffffff",
      'price': "\$500.00",
      'discount': "40% OFF",
      'rating': "4.7",
    },
    {
      'image': "https://via.placeholder.com/600x400/FFA07A/ffffff",
      'price': "\$600.00",
      'discount': "50% OFF",
      'rating': "4.8",
    },
    {
      'image': "https://via.placeholder.com/600x400/ADD8E6/ffffff",
      'price': "\$700.00",
      'discount': "60% OFF",
      'rating': "4.9",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(
            vertical: 16), // Added padding for spacing
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
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: NetworkImage(
                  "https://via.placeholder.com/600x400/90EE90/ffffff",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Manage your Logistics",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "All in one dashboard.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "3PL Software",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "24/7 Support",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Horizontal Scrollbar Buttons
          const SlideBarButtonList(),
          // Spaces Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Spaces",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 10),
                Column(
                children: List<Widget>.generate(spaces.length, (index) {
                  final space = spaces[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                space['image'],
                                cacheKey: space["image"],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${space['price']}",
                                    style: const TextStyle(fontSize: 18)),
                                Text("${space['discount']}",
                                    style: const TextStyle(fontSize: 16)),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star, size: 24),
                                Text('${space['rating']}',
                                    style: const TextStyle(fontSize: 16)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
