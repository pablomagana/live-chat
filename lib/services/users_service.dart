import 'package:lifechat/global/environment.dart';
import 'package:lifechat/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:lifechat/models/users_response.dart';
import 'package:lifechat/services/auth_service.dart';

class UsersService {
  Future<List<User>> getUsuarios() async {
    try {
      final resp = await http.get('${Environment.url}/users/all',
          headers: {'Content-Type': 'application/json', 'x-token': await AuthService.getToken()});

      final users = UsersResponse.fromJson(resp.body);

      return users.users;
    } catch (e) {
      return [];
    }
  }
}
