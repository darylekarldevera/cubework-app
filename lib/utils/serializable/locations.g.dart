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
      rail: json['rail'] as bool? ?? false,
      crane: json['crane'] as bool? ?? false,
      yard: json['yard'] as bool? ?? false,
      trailerParking: json['trailerParking'] as bool? ?? false,
      officeSpace: json['officeSpace'] as bool? ?? false,
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

Amenities _$AmenitiesFromJson(Map<String, dynamic> json) => Amenities(
      minStorageUnits: json['minStorageUnits'] as bool? ?? false,
      loadingDocks: json['loadingDocks'] as bool? ?? false,
      climateControl: json['climateControl'] as bool? ?? false,
      onSiteStaff: json['onSiteStaff'] as bool? ?? false,
      packagingSupplies: json['packagingSupplies'] as bool? ?? false,
      rackingSystems: json['rackingSystems'] as bool? ?? false,
      securitySystems: json['securitySystems'] as bool? ?? false,
      fireSuppressionSystems: json['fireSuppressionSystems'] as bool? ?? false,
      access24_7: json['access24_7'] as bool? ?? false,
      forkliftAvailability: json['forkliftAvailability'] as bool? ?? false,
      wifiAccess: json['wifiAccess'] as bool? ?? false,
      backupGenerators: json['backupGenerators'] as bool? ?? false,
      cctvSurveillance: json['cctvSurveillance'] as bool? ?? false,
      accessControlSystems: json['accessControlSystems'] as bool? ?? false,
      palletJacks: json['palletJacks'] as bool? ?? false,
      sprinklerSystems: json['sprinklerSystems'] as bool? ?? false,
      breakRooms: json['breakRooms'] as bool? ?? false,
      conferenceRooms: json['conferenceRooms'] as bool? ?? false,
      restrooms: json['restrooms'] as bool? ?? false,
      truckParking: json['truckParking'] as bool? ?? false,
      wasteDisposal: json['wasteDisposal'] as bool? ?? false,
      elevatorAccess: json['elevatorAccess'] as bool? ?? false,
      highCeilings: json['highCeilings'] as bool? ?? false,
      ventilationSystems: json['ventilationSystems'] as bool? ?? false,
      energyEfficientLighting:
          json['energyEfficientLighting'] as bool? ?? false,
    );

Map<String, dynamic> _$AmenitiesToJson(Amenities instance) => <String, dynamic>{
      'minStorageUnits': instance.minStorageUnits,
      'loadingDocks': instance.loadingDocks,
      'climateControl': instance.climateControl,
      'onSiteStaff': instance.onSiteStaff,
      'packagingSupplies': instance.packagingSupplies,
      'rackingSystems': instance.rackingSystems,
      'securitySystems': instance.securitySystems,
      'fireSuppressionSystems': instance.fireSuppressionSystems,
      'access24_7': instance.access24_7,
      'forkliftAvailability': instance.forkliftAvailability,
      'wifiAccess': instance.wifiAccess,
      'backupGenerators': instance.backupGenerators,
      'cctvSurveillance': instance.cctvSurveillance,
      'accessControlSystems': instance.accessControlSystems,
      'palletJacks': instance.palletJacks,
      'sprinklerSystems': instance.sprinklerSystems,
      'breakRooms': instance.breakRooms,
      'conferenceRooms': instance.conferenceRooms,
      'restrooms': instance.restrooms,
      'truckParking': instance.truckParking,
      'wasteDisposal': instance.wasteDisposal,
      'elevatorAccess': instance.elevatorAccess,
      'highCeilings': instance.highCeilings,
      'ventilationSystems': instance.ventilationSystems,
      'energyEfficientLighting': instance.energyEfficientLighting,
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
      amenities: json['amenities'] == null
          ? null
          : Amenities.fromJson(json['amenities'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WarehouseToJson(Warehouse instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'propertyDetails': instance.propertyDetails,
      'amenities': instance.amenities,
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
