import 'package:flutter/material.dart';
import 'package:cubework_app_client/widgets/explore_screen_space_card.dart';

import 'package:cubework_app_client/models/warehouse.dart';
import 'package:cubework_app_client/services/fetch_warehouse_locations.dart';

class ExploreScreenSpaceList extends StatefulWidget {
  const ExploreScreenSpaceList({super.key});

  @override
  State<ExploreScreenSpaceList> createState() => _ExploreScreenSpaceListState();
}

class _ExploreScreenSpaceListState extends State<ExploreScreenSpaceList> {
  late List<Warehouse> spaces = [];

  @override
  void initState() {
    super.initState();
    fetchSpaces();
  }

  void fetchSpaces() async {
    try {
      Future.delayed(const Duration(seconds: 3));
      final List<Warehouse> data = await fetchWarehouseLocations();
      setState(() {
        spaces = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List<Widget>.generate(spaces.length, (index) {
        final space = spaces[index];
        return ExploreScreenSpaceCard(space: space);
      }),
    );
  }
}
