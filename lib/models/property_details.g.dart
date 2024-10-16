// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
