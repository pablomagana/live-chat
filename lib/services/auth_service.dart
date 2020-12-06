import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lifechat/global/environment.dart';
import 'package:lifechat/models/login_response.dart';
import 'package:lifechat/models/user.dart';

class AuthService with ChangeNotifier {
  User user;
  bool _authenticating = false;

  final storage = new FlutterSecureStorage();

  bool get authenticating => _authenticating;
  set authenticating(bool v) {
    this._authenticating = v;
    notifyListeners();
  }

  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future login(String email, String password) async {
    final data = {'email': email, 'password': password};

    final resp = await http.post('${Environment.url}/auth/login',
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    print(resp.body);
    final loginResponse = LoginResponse.fromJson(resp.body);
    if (resp.statusCode == 200 && loginResponse.ok) {
      this.user = loginResponse.user;
      this._saveToken(loginResponse.token);
    }
    authenticating = false;

    return loginResponse.ok;
  }

  Future register(String name, String email, String password) async {
    final data = {'name': name, 'email': email, 'password': password};

    final resp = await http.post('${Environment.url}/auth/new',
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    print(resp.body);
    final loginResponse = LoginResponse.fromJson(resp.body);
    if (resp.statusCode == 200 && loginResponse.ok) {
      this.user = loginResponse.user;
      this._saveToken(loginResponse.token);
    }
    authenticating = false;

    return loginResponse.ok;
  }

  Future _saveToken(String token) async {
    return await storage.write(key: 'token', value: token);
  }

  Future removeToken() async {
    await storage.delete(key: 'token');
  }

  Future isLogged() async {
    final token = await storage.read(key: 'token');

    final resp = await http.get('${Environment.url}/auth/refresh',
        headers: {'Content-Type': 'application/json', 'x-token': token});

    print("refresh ${resp.body}");
    final loginResponse = LoginResponse.fromJson(resp.body);
    if (resp.statusCode == 200 && loginResponse.ok) {
      this.user = loginResponse.user;
      this._saveToken(loginResponse.token);
      return true;
    } else {
      this.removeToken();
      return false;
    }
  }
}
