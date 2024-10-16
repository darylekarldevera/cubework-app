import 'package:json_annotation/json_annotation.dart';

part 'property_details.g.dart';

@JsonSerializable()
class PropertyDetails {
  final String clearHeight;
  final String warehouseFloor;
  final int exteriorDockDoors;
  final int interiorDockDoors;
  final int driveInBays;
  final int driveInDoors;
  final bool rail;
  final bool crane;
  final bool yard;
  final bool trailerParking;
  final bool officeSpace;
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
    this.rail = false,
    this.crane = false,
    this.yard = false,
    this.trailerParking = false,
    this.officeSpace = false,
    this.standardParkingSpaces = 0,
    this.trailerParkingSpaces = 0,
    this.totalParkingSpaces = 0,
  });

  factory PropertyDetails.fromJson(Map<String, dynamic> json) =>
      _$PropertyDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyDetailsToJson(this);
}
