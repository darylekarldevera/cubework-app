import 'package:json_annotation/json_annotation.dart';
import 'package:cubework_app_client/models/amenities.dart';
import 'package:cubework_app_client/models/location.dart';
import 'package:cubework_app_client/models/property_details.dart';

part 'warehouse.g.dart';

@JsonSerializable()
class Warehouse {
  final String name;
  final String description;
  final Location location;
  final PropertyDetails propertyDetails;
  final Amenities amenities;

  Warehouse({
    this.name = '',
    this.description = '',
    Location? location,
    PropertyDetails? propertyDetails,
    Amenities? amenities,
  })  : location = location ?? Location(),
        propertyDetails = propertyDetails ?? PropertyDetails(),
        amenities = amenities ?? Amenities();

  factory Warehouse.fromJson(Map<String, dynamic> json) =>
      _$WarehouseFromJson(json);

  Map<String, dynamic> toJson() => _$WarehouseToJson(this);
}
