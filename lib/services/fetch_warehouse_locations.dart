
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:cubework_app_client/models/warehouse.dart';

Future<List<Warehouse>> fetchWarehouseLocations() async {
  String locationsURL =
      await rootBundle.loadString('lib/assets/locations.json');
  // Retrieve the locations of Google Warehouses
  try {
    final response = await http.get(Uri.parse(locationsURL));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList =
          json.decode(response.body) as List<dynamic>;

      final List<Warehouse> warehouses = jsonList
          .map((json) => Warehouse.fromJson(json as Map<String, dynamic>))
          .toList();

      return warehouses;
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }

  // Fallback for when the above HTTP request fails.
  return <Warehouse>[];
}
