import 'package:json_annotation/json_annotation.dart';

import 'package:najikkopasal/model/profile_model.dart';
part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  bool? success;
  Profile? user;
  ProfileResponse({this.success, this.user});
  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return _$ProfileResponseFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}
