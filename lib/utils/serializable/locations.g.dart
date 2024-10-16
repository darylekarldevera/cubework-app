// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatLng _$LatLngFromJson(Map<String, dynamic> json) => LatLng(
      lat: (json['lat'] as num?)?.toDouble() ?? 0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$LatLngToJson(LatLng instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      address: json['address'] as String? ?? '',
      city: json['city'] as String? ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'address': instance.address,
      'city': instance.city,
      'lat': instance.lat,
      'lng': instance.lng,
    };

PropertyDetails _$PropertyDetailsFromJson(Map<String, dynamic> json) =>
    PropertyDetails(
      clearHeight: json['clearHeight'] as String? ?? '',
      warehouseFloor: json['warehouseFloor'] as String? ?? '',
      exteriorDockDoors: (json['exteriorDockDoors'] as num?)?.toInt() ?? 0,
      interiorDockDoors: (json['interiorDockDoors'] as num?)?.toInt() ?? 0,
      driveInBays: (json['driveInBays'] as num?)?.toInt() ?? 0,
      driveInDoors: (json['driveInDoors'] as num?)?.toInt() ?? 0,
      rail: json['rail'] as String? ?? '',
      crane: json['crane'] as String? ?? '',
      yard: json['yard'] as String? ?? '',
      trailerParking: json['trailerParking'] as String? ?? '',
      officeSpace: json['officeSpace'] as String? ?? '',
      standardParkingSpaces:
          (json['standardParkingSpaces'] as num?)?.toInt() ?? 0,
      trailerParkingSpaces:
          (json['trailerParkingSpaces'] as num?)?.toInt() ?? 0,
      totalParkingSpaces: (json['totalParkingSpaces'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PropertyDetailsToJson(PropertyDetails instance) =>
    <String, dynamic>{
      'clearHeight': instance.clearHeight,
      'warehouseFloor': instance.warehouseFloor,
      'exteriorDockDoors': instance.exteriorDockDoors,
      'interiorDockDoors': instance.interiorDockDoors,
      'driveInBays': instance.driveInBays,
      'driveInDoors': instance.driveInDoors,
      'rail': instance.rail,
      'crane': instance.crane,
      'yard': instance.yard,
      'trailerParking': instance.trailerParking,
      'officeSpace': instance.officeSpace,
      'standardParkingSpaces': instance.standardParkingSpaces,
      'trailerParkingSpaces': instance.trailerParkingSpaces,
      'totalParkingSpaces': instance.totalParkingSpaces,
    };

Warehouse _$WarehouseFromJson(Map<String, dynamic> json) => Warehouse(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      propertyDetails: json['propertyDetails'] == null
          ? null
          : PropertyDetails.fromJson(
              json['propertyDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WarehouseToJson(Warehouse instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'propertyDetails': instance.propertyDetails,
    };

Warehouses _$WarehousesFromJson(Map<String, dynamic> json) => Warehouses(
      warehouses: (json['warehouses'] as List<dynamic>?)
          ?.map((e) => Warehouse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WarehousesToJson(Warehouses instance) =>
    <String, dynamic>{
      'warehouses': instance.warehouses,
    };
