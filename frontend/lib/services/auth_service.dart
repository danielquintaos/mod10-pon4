import 'api_service.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final ApiService _apiService;

  AuthService(String baseUrl) : _apiService = ApiService(baseUrl);

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await _apiService.post('/users/login', {'username': username, 'password': password});
    return _parseResponse(response);
  }

  Future<Map<String, dynamic>> signup(String username, String email, String password) async {
    final response = await _apiService.post('/users/signup', {'username': username, 'email': email, 'password': password});
    return _parseResponse(response);
  }

  Map<String, dynamic> _parseResponse(http.Response response) {
    return json.decode(response.body) as Map<String, dynamic>;
  }
}
