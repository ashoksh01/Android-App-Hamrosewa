// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************
Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['_id'] as String?,
      orderItems: (json['orderItems'] as List<dynamic>?)
          ?.map((e) => OrderItems.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: json['totalPrice'] as int?,
      orderStatus: json['orderStatus'] as String?,
    );
Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      '_id': instance.id,
      'orderItems': instance.orderItems,
      'totalPrice': instance.totalPrice,
      'orderStatus': instance.orderStatus,
    };
