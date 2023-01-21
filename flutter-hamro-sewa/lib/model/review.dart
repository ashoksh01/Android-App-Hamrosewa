import 'package:json_annotation/json_annotation.dart';
part 'review.g.dart';

@JsonSerializable()
class Review {
  String? time;
  String? name;
  int? rating;
  String? comment;

  Review({this.time, this.name, this.rating, this.comment});

  factory Review.fromJson(Map<String, dynamic> json) {
    return _$ReviewFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
