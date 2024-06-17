import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../lib/providers/image_provider.dart';
import '../lib/models/image.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('ImageProvider', () {
    MockClient client;
    ImageProvider imageProvider;

    setUp(() {
      client = MockClient();
      imageProvider = ImageProvider();
    });

    test('Upload image successful', () async {
      final filePath = 'path/to/test_image.png';

      when(client.send(any)).thenAnswer(
        (_) async => http.StreamedResponse(
          Stream.value(utf8.encode(json.encode({'id': 1, 'filename': 'test_image.png', 'filtered_filename': 'filtered_test_image.png'}))),
          200,
        ),
      );

      await imageProvider.uploadImage(filePath);
      expect(imageProvider.images, isNotEmpty);
      expect(imageProvider.images.first, isA<ImageModel>());
      expect(imageProvider.images.first.filename, 'test_image.png');
    });

    test('Upload image failed', () async {
      final filePath = 'path/to/test_image.png';

      when(client.send(any)).thenAnswer(
        (_) async => http.StreamedResponse(
          Stream.value(utf8.encode('Upload failed')),
          400,
        ),
      );

      expect(() => imageProvider.uploadImage(filePath), throwsException);
    });

    test('Fetch images successful', () async {
      when(client.get(any)).thenAnswer(
        (_) async => http.Response(json.encode([
          {'id': 1, 'filename': 'test_image.png', 'filtered_filename': 'filtered_test_image.png'}
        ]), 200),
      );

      await imageProvider.fetchImages();
      expect(imageProvider.images, isNotEmpty);
      expect(imageProvider.images.first, isA<ImageModel>());
      expect(imageProvider.images.first.filename, 'test_image.png');
    });

    test('Fetch images failed', () async {
      when(client.get(any)).thenAnswer(
        (_) async => http.Response('Fetch failed', 400),
      );

      expect(() => imageProvider.fetchImages(), throwsException);
    });
  });
}
