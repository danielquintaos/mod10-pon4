import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../lib/providers/auth_provider.dart';
import '../lib/models/user.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('AuthProvider', () {
    MockClient client;
    AuthProvider authProvider;

    setUp(() {
      client = MockClient();
      authProvider = AuthProvider();
    });

    test('Signup successful', () async {
      final username = 'testuser';
      final email = 'testuser@example.com';
      final password = 'testpassword';

      when(client.post(any, body: anyNamed('body'))).thenAnswer(
        (_) async => http.Response(json.encode({'id': 1, 'username': username, 'email': email}), 200),
      );

      await authProvider.signup(username, email, password);
      expect(authProvider.user, isA<User>());
      expect(authProvider.user.username, username);
    });

    test('Signup failed', () async {
      final username = 'testuser';
      final email = 'testuser@example.com';
      final password = 'testpassword';

      when(client.post(any, body: anyNamed('body'))).thenAnswer(
        (_) async => http.Response('Signup failed', 400),
      );

      expect(() => authProvider.signup(username, email, password), throwsException);
    });

    test('Login successful', () async {
      final username = 'testuser';
      final password = 'testpassword';

      when(client.post(any, body: anyNamed('body'))).thenAnswer(
        (_) async => http.Response(json.encode({'access_token': 'testtoken'}), 200),
      );

      await authProvider.login(username, password);
      expect(authProvider.token, isNotNull);
      expect(authProvider.token, 'testtoken');
    });

    test('Login failed', () async {
      final username = 'testuser';
      final password = 'testpassword';

      when(client.post(any, body: anyNamed('body'))).thenAnswer(
        (_) async => http.Response('Login failed', 400),
      );

      expect(() => authProvider.login(username, password), throwsException);
    });
  });
}
