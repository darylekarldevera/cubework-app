

import 'package:json_annotation/json_annotation.dart';

part 'rating.g.dart';

@JsonSerializable()
class Rating {
  final double stars;

  Rating({
    this.stars = 0.0,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => 
    _$RatingFromJson(json);

  Map<String, dynamic> toJson() => _$RatingToJson(this);
}