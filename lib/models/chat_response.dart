// To parse this JSON data, do
//
//     final chatResponse = chatResponseFromMap(jsonString);

import 'dart:convert';

class ChatResponse {
  ChatResponse({
    this.ok,
    this.messages,
  });

  bool ok;
  List<Message> messages;

  factory ChatResponse.fromJson(String str) => ChatResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChatResponse.fromMap(Map<String, dynamic> json) => ChatResponse(
        ok: json["ok"],
        messages: List<Message>.from(json["messages"].map((x) => Message.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ok": ok,
        "messages": List<dynamic>.from(messages.map((x) => x.toMap())),
      };
}

class Message {
  Message({
    this.id,
    this.userTo,
    this.userFrom,
    this.msg,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  String userTo;
  String userFrom;
  String msg;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Message.fromJson(String str) => Message.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Message.fromMap(Map<String, dynamic> json) => Message(
        id: json["_id"],
        userTo: json["userTo"],
        userFrom: json["userFrom"],
        msg: json["msg"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "userTo": userTo,
        "userFrom": userFrom,
        "msg": msg,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
