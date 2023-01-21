import 'package:json_annotation/json_annotation.dart';
import 'package:najikkopasal/model/image.dart';
part 'profile_model.g.dart';

@JsonSerializable()
class Profile {
  String? name;
  Image? image;
  String? email;
  String? createdAt;
  Profile({this.name, this.image, this.email, this.createdAt});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return _$ProfileFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
