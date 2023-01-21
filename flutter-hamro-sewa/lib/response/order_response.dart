import 'package:json_annotation/json_annotation.dart';
import 'package:najikkopasal/model/order.dart';

part 'order_response.g.dart';

@JsonSerializable()
class OrderResponse {
  bool? success;
  List<Order>? orders;
  OrderResponse({this.success, this.orders});
  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}
