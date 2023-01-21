// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return Review(
    time: json['time'] as String?,
    name: json['name'] as String?,
    rating: json['rating'] as int?,
    comment: json['comment'] as String?,
  );
}

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'time': instance.time,
      'name': instance.name,
      'rating': instance.rating,
      'comment': instance.comment,
    };
