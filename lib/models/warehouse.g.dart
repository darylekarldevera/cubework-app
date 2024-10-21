// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Warehouse _$WarehouseFromJson(Map<String, dynamic> json) => Warehouse(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
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
      price: json['price'] == null
          ? null
          : Price.fromJson(json['price'] as Map<String, dynamic>),
      rating: json['rating'] == null
          ? null
          : Rating.fromJson(json['rating'] as Map<String, dynamic>),
      tag: json['tag'] == null
          ? null
          : Tag.fromJson(json['tag'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WarehouseToJson(Warehouse instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'images': instance.images,
      'location': instance.location,
      'propertyDetails': instance.propertyDetails,
      'amenities': instance.amenities,
      'price': instance.price,
      'rating': instance.rating,
      'tag': instance.tag,
    };
