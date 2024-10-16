import 'package:cached_network_image/cached_network_image.dart';
import 'package:cubework_app_client/constants/warehouse_amenities_icons.dart';
import 'package:cubework_app_client/utils/camel_to_sentence.dart';
import 'package:cubework_app_client/utils/serializable/locations.dart';
import 'package:flutter/material.dart';

class WarehouseDetailsScreen extends StatefulWidget {
  final Warehouse warehouse;
  const WarehouseDetailsScreen({super.key, required this.warehouse});

  @override
  State<WarehouseDetailsScreen> createState() => _WarehouseDetailsScreenState();
}

class _WarehouseDetailsScreenState extends State<WarehouseDetailsScreen> {
  late Warehouse _warehouse;
  bool isShowMoreDescription = false;
  bool isShowMorePropertyDetails = false;
  bool isShowMoreAmenities = false;

  List<String> objectKeys(dynamic propertyDetails) {
    return propertyDetails.toJson().keys.toList();
  }

  @override
  initState() {
    super.initState();
    _warehouse = widget.warehouse;
  }

  String getDescription() {
    if (isShowMoreDescription) {
      return _warehouse.description;
    }

    return "${_warehouse.description.substring(0, 50)}...";
  }

  String getPropertyValue(dynamic key) {
    final value =_warehouse.propertyDetails.toJson()[key];
    
    if (value is bool) {
      return value ? "Yes" : "No";
    }

    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      Stack(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: CachedNetworkImage(
                imageUrl: 'https://via.placeholder.com/600x400/90EE90/ffffff',
                errorWidget: (context, url, error) => Image.asset(
                    "lib/assets/images/placeholder_horizontal.jpg",
                    fit: BoxFit.cover),
                placeholder: (context, url) =>
                    Image.asset("lib/assets/images/placeholder_horizontal.jpg"),
                fit: BoxFit.cover),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => {},
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.share),
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () => {},
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.favorite_outline),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Aligns children to the start
          children: [
            Row(
              children: [
                const Text(
                  "\$2666.99",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8), // Add space here
                const Text(
                  "\$2745.69",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.lightGreen[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text("40% OFF",
                      style: TextStyle(color: Colors.green)),
                ),
              ],
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Listing Tile"),
                Text("Warehouse ID: 429",
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: const Row(
                children: [
                  Icon(Icons.star, size: 24),
                  Text('4.8', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 15),
              child: Row(
                children: [
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[50],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text("Warehouse",
                          style: TextStyle(color: Colors.blue))),
                  const SizedBox(width: 8),
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[50],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text("Complete Warehouse",
                          style: TextStyle(color: Colors.blue)))
                ],
              ),
            ),
            // Reserve controllers
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () => {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Start Date"),
                            Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    )),
                    const SizedBox(width: 40),
                    Expanded(
                        child: GestureDetector(
                      onTap: () => {},
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("End Date"),
                              Icon(Icons.calendar_today),
                            ],
                          )),
                    ))
                  ],
                ),
                GestureDetector(
                  onTap: () => {},
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.green, width: 1),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Reserve", style: TextStyle(color: Colors.green)),
                        SizedBox(width: 5),
                        Icon(Icons.arrow_drop_down_sharp, color: Colors.green),
                      ],
                    ),
                  ),
                ),

                // Description
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                  ),
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Description",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text(getDescription()),
                      GestureDetector(
                        onTap: () => {
                          setState(() {
                            isShowMoreDescription = !isShowMoreDescription;
                          })
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(
                            // Ensures the row takes up the minimum space needed
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                isShowMoreDescription
                                    ? "Show less"
                                    : "Show all",
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                isShowMoreDescription
                                    ? Icons.arrow_drop_up_sharp
                                    : Icons.arrow_drop_down_sharp,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Building Highlights
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                  ),
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Building Highlights",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      // Property details
                      ...objectKeys(_warehouse.propertyDetails)
                          .asMap()
                          .entries
                          .map((entry) {
                        final int index = entry.key;
                        final key = entry.value;

                        // Show only 5 items if show more is not clicked
                        if (!isShowMorePropertyDetails && index > 4) {
                          return Container();
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(camelToSentence(key.toString())),
                            Text(getPropertyValue(key),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      }),
                      GestureDetector(
                        onTap: () => {
                          setState(() {
                            isShowMorePropertyDetails =
                                !isShowMorePropertyDetails;
                          })
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(
                            // Ensures the row takes up the minimum space needed
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                isShowMorePropertyDetails
                                    ? "Show less"
                                    : "Show all",
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                isShowMorePropertyDetails
                                    ? Icons.arrow_drop_up_sharp
                                    : Icons.arrow_drop_down_sharp,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Amenities
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                  ),
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Amenities",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      // Property details
                      ...objectKeys(_warehouse.amenities)
                          .asMap()
                          .entries
                          .map((entry) {
                        final int index = entry.key;
                        final key = entry.value;

                        // Show only 5 items if show more is not clicked
                        if (!isShowMoreAmenities && index > 4) {
                          return Container();
                        }

                        // if the value is false, return none
                        if (_warehouse.amenities.toJson()[key] == false) {
                          return Container();
                        }

                        return Container(
                          margin: const EdgeInsets.symmetric(vertical:5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                amenityIcons[key],
                              ),
                              const SizedBox(width: 15),
                              Text(camelToSentence(key.toString())),
                            ],
                          ),
                        );
                      }),
                      GestureDetector(
                        onTap: () => {
                          setState(() {
                            isShowMoreAmenities =
                                !isShowMoreAmenities;
                          })
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(
                            // Ensures the row takes up the minimum space needed
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                isShowMoreAmenities
                                    ? "Show less"
                                    : "Show all",
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 3),
                              Icon(
                                isShowMoreAmenities
                                    ? Icons.arrow_drop_up_sharp
                                    : Icons.arrow_drop_down_sharp,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      )
    ]));
  }
}
