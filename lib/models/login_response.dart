import 'dart:convert';

import 'package:lifechat/models/user.dart';

class LoginResponse {
  LoginResponse({this.ok, this.user, this.token});

  bool ok;
  User user;
  String token;

  factory LoginResponse.fromJson(String str) => LoginResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
      ok: json["ok"],
      user: json["ok"] == true ? User.fromMap(json["user"]) : null,
      token: json["ok"] == true ? json["token"] : null);

  Map<String, dynamic> toMap() => {"ok": ok, "user": user.toMap(), "token": token};
}
