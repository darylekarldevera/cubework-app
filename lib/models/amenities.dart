import 'package:json_annotation/json_annotation.dart';

part 'amenities.g.dart';

@JsonSerializable()
class Amenities {
  final bool minStorageUnits;
  final bool loadingDocks;
  final bool climateControl;
  final bool onSiteStaff;
  final bool packagingSupplies;
  final bool rackingSystems;
  final bool securitySystems;
  final bool fireSuppressionSystems;
  final bool access24_7;
  final bool forkliftAvailability;
  final bool wifiAccess;
  final bool backupGenerators;
  final bool cctvSurveillance;
  final bool accessControlSystems;
  final bool palletJacks;
  final bool sprinklerSystems;
  final bool breakRooms;
  final bool conferenceRooms;
  final bool restrooms;
  final bool truckParking;
  final bool wasteDisposal;
  final bool elevatorAccess;
  final bool highCeilings;
  final bool ventilationSystems;
  final bool energyEfficientLighting;

  Amenities({
    this.minStorageUnits = false,
    this.loadingDocks = false,
    this.climateControl = false,
    this.onSiteStaff = false,
    this.packagingSupplies = false,
    this.rackingSystems = false,
    this.securitySystems = false,
    this.fireSuppressionSystems = false,
    this.access24_7 = false,
    this.forkliftAvailability = false,
    this.wifiAccess = false,
    this.backupGenerators = false,
    this.cctvSurveillance = false,
    this.accessControlSystems = false,
    this.palletJacks = false,
    this.sprinklerSystems = false,
    this.breakRooms = false,
    this.conferenceRooms = false,
    this.restrooms = false,
    this.truckParking = false,
    this.wasteDisposal = false,
    this.elevatorAccess = false,
    this.highCeilings = false,
    this.ventilationSystems = false,
    this.energyEfficientLighting = false,
  });

  factory Amenities.fromJson(Map<String, dynamic> json) =>
      _$AmenitiesFromJson(json);
  Map<String, dynamic> toJson() => _$AmenitiesToJson(this);
}
