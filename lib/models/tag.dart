
import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@JsonSerializable()
class Tag {
  final List<String> label;

  Tag({
    this.label = const [],
  });

  factory Tag.fromJson(Map<String, dynamic> json) => 
    _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}