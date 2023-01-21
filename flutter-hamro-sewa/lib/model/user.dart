class User {
  String? name;
  String? email;
  String? password;
  String? image;
  

  User({this.name, this.email, this.password, this.image});

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "image": image,
      };
}
