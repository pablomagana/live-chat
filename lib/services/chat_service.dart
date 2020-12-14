import 'package:flutter/material.dart';
import 'package:lifechat/global/environment.dart';
import 'package:lifechat/models/chat_response.dart';
import 'package:lifechat/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:lifechat/services/auth_service.dart';

class ChatService with ChangeNotifier {
  User userTo;

  Future<List<Message>> getChat(String userID) async {
    final resp = await http.get('${Environment.url}/msg/$userID',
        headers: {'Content-Type': 'application/json', 'x-token': await AuthService.getToken()});

    final msgResp = ChatResponse.fromJson(resp.body);

    return msgResp.messages;
  }
}
