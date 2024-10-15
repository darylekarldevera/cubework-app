import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'locations.g.dart';

@JsonSerializable()
class LatLng {
  LatLng({
    required this.lat,
    required this.lng,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngToJson(this);

  final double lat;
  final double lng;
}

@JsonSerializable()
class Warehouse {
  Warehouse({
    required this.address,
    required this.lat,
    required this.lng,
    required this.name,
    required this.city,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) => _$WarehouseFromJson(json);
  Map<String, dynamic> toJson() => _$WarehouseToJson(this);

  final String address;
  final double lat;
  final double lng;
  final String name;
  final String city;
}

@JsonSerializable()
class Locations {
  Locations({
    required this.warehouses,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<Warehouse> warehouses;
}

Future<Locations> getUnitOfferingLocations() async {
  String locationsURL = await rootBundle.loadString('lib/assets/locations.json');
  // Retrieve the locations of Google Warehouses
  try {
    final response = await http.get(Uri.parse(locationsURL));
    if (response.statusCode == 200) {
      return Locations.fromJson(
          json.decode(response.body) as Map<String, dynamic>);
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }

  // Fallback for when the above HTTP request fails.
  return Locations.fromJson(
    json.decode(
      await rootBundle.loadString('lib/assets/locations.json'),
    ) as Map<String, dynamic>,
  );
}
