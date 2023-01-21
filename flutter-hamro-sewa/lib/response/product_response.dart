import 'package:json_annotation/json_annotation.dart';
import 'package:najikkopasal/model/product_model.dart';
part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse {
  bool? success;
  List<Product>? data;
  ProductResponse({this.success, this.data});
  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return _$ProductResponseFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}
              