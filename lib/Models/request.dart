// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? expiresInMins;
  String? password;
  String? username;

  User({this.expiresInMins, this.password, this.username});

  factory User.fromJson(Map<String, dynamic> json) => User(
    expiresInMins: json["expiresInMins"],
    password: json["password"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "expiresInMins": expiresInMins,
    "password": password,
    "username": username,
  };
}
