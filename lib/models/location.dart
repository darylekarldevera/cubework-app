import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

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
