// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
      stars: (json['stars'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'stars': instance.stars,
    };
