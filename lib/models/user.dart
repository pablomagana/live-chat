import 'dart:convert';

class User {
  User({this.name, this.email, this.uid, this.online});

  String name;
  String email;
  String uid;
  bool online;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) =>
      User(name: json["name"], email: json["email"], uid: json["uid"], online: json['online']);

  Map<String, dynamic> toMap() => {"name": name, "email": email, "uid": uid, "online": online};
}
