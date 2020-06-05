import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class AuthHelper {
  static const String API_URL = "https://homechef-backend.herokuapp.com/";
  final storage = FlutterSecureStorage();

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept-Encoding": "gzip, deflate, br",
    "Connection": "keep-alive"
  };

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "homechef-jwt");
    if (jwt == null) return "";
    return jwt;
  }

  void deleteTokenJwt() async {
    await storage.delete(key: "homechef-jwt");
  }

  void logout() async {
    this.deleteTokenJwt();
  }

  Future<String> login(String username, String password) async {
    var res = await http.post(API_URL + 'api/auth/login',
        headers: headers,
        body: json.encode({"username": username, "password": password}));

    print("Login res.body " + res.body);

    if (res.statusCode == 200) return res.body;
    return null;
  }

  Future<int> attemptSignUp(
      String username, String password, String email) async {
    var res = await http.post(API_URL + 'api/auth/register',
        headers: headers,
        body: json.encode(
            {"username": username, "password": password, "email": email}));
    print("Signup res.body" + res.body);
    return res.statusCode;
  }
}
