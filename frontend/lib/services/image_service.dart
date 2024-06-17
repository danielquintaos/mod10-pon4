import 'api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ImageService {
  final ApiService _apiService;

  ImageService(String baseUrl) : _apiService = ApiService(baseUrl);

  Future<Map<String, dynamic>> uploadImage(String filePath) async {
    final file = await http.MultipartFile.fromPath('file', filePath);
    final response = await _apiService.postMultipart('/images/upload', {}, [file]);
    return _parseResponse(response);
  }

  Future<List<Map<String, dynamic>>> fetchImages() async {
    final response = await _apiService.get('/images/download');
    return _parseListResponse(response);
  }

  Map<String, dynamic> _parseResponse(http.Response response) {
    return json.decode(response.body) as Map<String, dynamic>;
  }

  List<Map<String, dynamic>> _parseListResponse(http.Response response) {
    return List<Map<String, dynamic>>.from(json.decode(response.body));
  }
}
