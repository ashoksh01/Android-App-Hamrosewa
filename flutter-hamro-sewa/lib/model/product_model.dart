import 'package:json_annotation/json_annotation.dart';
import 'package:najikkopasal/model/image.dart';
import 'package:najikkopasal/model/review.dart';

part 'product_model.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: '_id')
  String? id;
  String? name;
  String? description;
  int? price;
  int? Stock;
  double? ratings;
  List<Image>? images;
  List<Review>? reviews;
  Product(
      {this.name,
      this.description,
      this.price,
      this.ratings,
      this.images,
      this.reviews,
      this.Stock,
      this.id});
  factory Product.fromJson(Map<String, dynamic> json) {
    return _$ProductFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
