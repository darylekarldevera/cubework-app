// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
