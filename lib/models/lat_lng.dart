import 'package:json_annotation/json_annotation.dart';

part 'lat_lng.g.dart';

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
