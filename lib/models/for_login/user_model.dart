import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel();

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String username;
  String password;

  UserModel({
    this.username,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
