import 'dart:io';

class Environment {
  //static String url = 'https://livechatnode.herokuapp.com/api';
  //static String socketUrl = 'https://livechatnode.herokuapp.com';
  //static String url = 'http://10.0.2.2:3001/api';
  //static String socketUrl = 'http://10.0.2.2:3001';

  static String url = Platform.isAndroid ? 'http://10.0.2.2:3001/api' : 'http://localhost:3001/api';
  static String socketUrl = Platform.isAndroid ? 'http://10.0.2.2:3001' : 'http://localhost:3001';
}
