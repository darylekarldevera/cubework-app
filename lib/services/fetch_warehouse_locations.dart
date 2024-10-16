import 'dart:convert';
import 'package:cubework_app_client/models/warehouse.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

Future<List<Warehouse>> fetchWarehouseLocations() async {
  try {
    final String response =
        await rootBundle.loadString('lib/assets/locations.json');
        
    final Map<String, dynamic> jsonObject =
        json.decode(response) as Map<String, dynamic>;
        
    final List<dynamic> jsonList = jsonObject['warehouses'] as List<dynamic>;

    final List<Warehouse> warehouses = jsonList
        .map((json) => Warehouse.fromJson(json as Map<String, dynamic>))
        .toList();

    return warehouses;
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return [];
  }
}
