import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  String? _token;

  User? get user => _user;
  String? get token => _token;

  Future<void> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(ApiConfig.baseUrl + ApiConfig.loginEndpoint),
      body: {'username': username, 'password': password},
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      _token = responseData['access_token'];
      notifyListeners();
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> signup(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse(ApiConfig.baseUrl + ApiConfig.signupEndpoint),
      body: {'username': username, 'email': email, 'password': password},
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      _user = User.fromJson(responseData);
      notifyListeners();
    } else {
      throw Exception('Failed to signup');
    }
  }
}
