
import 'package:json_annotation/json_annotation.dart';
part 'orderItems.g.dart';

@JsonSerializable()
class OrderItems {
  String? name;
  int? price;
  int? quantity;
  String? image;
  OrderItems({this.name, this.price, this.quantity, this.image});
  factory OrderItems.fromJson(Map<String, dynamic> json) =>
      _$OrderItemsFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemsToJson(this);
}
