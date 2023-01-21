class LoginResponse {
  bool? success;
  String? token;
  LoginResponse({this.success, this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(success: json["success"], token: json["token"]);
  }
  Map<String, dynamic> toJson() => {"success": success, "token": token};
}
