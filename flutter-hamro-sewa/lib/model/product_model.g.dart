// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    name: json['name'] as String?,
    description: json['description'] as String?,
    price: json['price'] as int?,
    ratings: (json['ratings'] as num?)?.toDouble(),
    images: (json['images'] as List<dynamic>?)
        ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
        .toList(),
    reviews: (json['reviews'] as List<dynamic>?)
        ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
        .toList(),
    Stock: json['Stock'] as int?,
    id: json['_id'] as String?,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'Stock': instance.Stock,
      'ratings': instance.ratings,
      'images': instance.images,
      'reviews': instance.reviews,
    };
