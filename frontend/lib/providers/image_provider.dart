import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';
import '../models/image.dart';

class ImageProvider with ChangeNotifier {
  List<ImageModel> _images = [];

  List<ImageModel> get images => _images;

  Future<void> uploadImage(String filePath) async {
    var request = http.MultipartRequest('POST', Uri.parse(ApiConfig.baseUrl + ApiConfig.uploadImageEndpoint));
    request.files.add(await http.MultipartFile.fromPath('file', filePath));
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await http.Response.fromStream(response);
      final image = ImageModel.fromJson(json.decode(responseData.body));
      _images.add(image);
      notifyListeners();
    } else {
      throw Exception('Failed to upload image');
    }
  }

  Future<void> fetchImages() async {
    final response = await http.get(Uri.parse(ApiConfig.baseUrl + ApiConfig.downloadImageEndpoint));
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body) as List;
      _images = responseData.map((image) => ImageModel.fromJson(image)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to fetch images');
    }
  }
}
