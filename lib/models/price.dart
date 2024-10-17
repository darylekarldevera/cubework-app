
import 'package:json_annotation/json_annotation.dart';

part 'price.g.dart';

@JsonSerializable()
class Price {
  final double originalPrice;
  final double currentPrice;
  final double discount;

  Price({
    this.originalPrice = 0.0,
    this.currentPrice = 0.0,
    this.discount = 0.0,
  });

  factory Price.fromJson(Map<String, dynamic> json) => 
    _$PriceFromJson(json);

  Map<String, dynamic> toJson() => _$PriceToJson(this);
}