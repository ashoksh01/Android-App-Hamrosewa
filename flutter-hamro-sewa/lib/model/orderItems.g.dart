// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'orderItems.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************
OrderItems _$OrderItemsFromJson(Map<String, dynamic> json) => OrderItems(
      name: json['name'] as String?,
      price: json['price'] as int?,
      quantity: json['quantity'] as int?,
      image: json['image'] as String?,
    );
Map<String, dynamic> _$OrderItemsToJson(OrderItems instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
      'image': instance.image,
    };
