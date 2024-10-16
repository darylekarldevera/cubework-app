import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'locations.g.dart';

@JsonSerializable()
class LatLng {
  final double lat;
  final double lng;

  LatLng({
    this.lat = 0,
    this.lng = 0,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngToJson(this);
}

@JsonSerializable()
class Location {
  final String address;
  final String city;
  final double lat;
  final double lng;

  Location({
    this.address = '',
    this.city = '',
    this.lat = 0.0,
    this.lng = 0.0,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}



class ProfileMark {
  final String name;
  final DateTime start = DateTime.now();

  ProfileMark(this.name);
  ProfileMark.unnamed() : name = '';
}

@JsonSerializable()
class PropertyDetails {
  final String clearHeight;
  final String warehouseFloor;
  final int exteriorDockDoors;
  final int interiorDockDoors;
  final int driveInBays;
  final int driveInDoors;
  final String rail;
  final String crane;
  final String yard;
  final String trailerParking;
  final String officeSpace;
  final int standardParkingSpaces;
  final int trailerParkingSpaces;
  final int totalParkingSpaces;

  PropertyDetails({
    this.clearHeight = '',
    this.warehouseFloor = '',
    this.exteriorDockDoors = 0,
    this.interiorDockDoors = 0,
    this.driveInBays = 0,
    this.driveInDoors = 0,
    this.rail = '',
    this.crane = '',
    this.yard = '',
    this.trailerParking = '',
    this.officeSpace = '',
    this.standardParkingSpaces = 0,
    this.trailerParkingSpaces = 0,
    this.totalParkingSpaces = 0,
  });

  
  factory PropertyDetails.fromJson(Map<String, dynamic> json) =>
      _$PropertyDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyDetailsToJson(this);
}


@JsonSerializable()
class Warehouse {
  final String name;
  final String description;
  final Location location;
  final PropertyDetails propertyDetails;

  Warehouse({
    this.name = '',
    this.description = '',
    Location? location,
    PropertyDetails? propertyDetails,
  })  : location = location ?? Location(),
        propertyDetails = propertyDetails ?? PropertyDetails();

  factory Warehouse.fromJson(Map<String, dynamic> json) =>
      _$WarehouseFromJson(json);

  Map<String, dynamic> toJson() => _$WarehouseToJson(this);
}

@JsonSerializable()
class Warehouses {
  final List<Warehouse> warehouses;
  
  Warehouses({
    List<Warehouse>? warehouses,
  }): warehouses = warehouses ?? <Warehouse>[];

  factory Warehouses.fromJson(Map<String, dynamic> json) =>
      _$WarehousesFromJson(json);
  Map<String, dynamic> toJson() => _$WarehousesToJson(this);
}

Future<Warehouses> getUnitOfferingLocations() async {
  String locationsURL =
      await rootBundle.loadString('lib/assets/locations.json');
  // Retrieve the locations of Google Warehouses
  try {
    final response = await http.get(Uri.parse(locationsURL));
    if (response.statusCode == 200) {
      return Warehouses.fromJson(
          json.decode(response.body) as Map<String, dynamic>);
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }

  // Fallback for when the above HTTP request fails.
  return Warehouses.fromJson(
    json.decode(
      await rootBundle.loadString('lib/assets/locations.json'),
    ) as Map<String, dynamic>,
  );
}
