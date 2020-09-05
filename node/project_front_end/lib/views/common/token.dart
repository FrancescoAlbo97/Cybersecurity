import 'dart:html';

class IdRepository {
  static Storage _localStorage = window.localStorage;

  static Future save(String token) async {
    _localStorage['token'] = token;
  }

  static Future<String> getId() async => _localStorage['token'];

  static Future invalidate() async {
    _localStorage.remove('token');
  }
}