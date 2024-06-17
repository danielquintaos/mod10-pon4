import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.get(url);
    _checkForErrors(response);
    return response;
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.post(url, body: json.encode(body), headers: _headers());
    _checkForErrors(response);
    return response;
  }

  Future<http.Response> postMultipart(String endpoint, Map<String, String> fields, List<http.MultipartFile> files) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final request = http.MultipartRequest('POST', url);
    request.fields.addAll(fields);
    request.files.addAll(files);
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    _checkForErrors(response);
    return response;
  }

  void _checkForErrors(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Failed request: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Map<String, String> _headers() {
    return {
      'Content-Type': 'application/json',
    };
  }
}
