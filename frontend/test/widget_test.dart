import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import '../lib/app.dart';
import '../lib/pages/auth/login_page.dart';
import '../lib/pages/auth/signup_page.dart';
import '../lib/pages/home/home_page.dart';
import '../lib/pages/home/upload_page.dart';
import '../lib/pages/home/download_page.dart';
import '../lib/providers/auth_provider.dart';
import '../lib/providers/image_provider.dart';

void main() {
  testWidgets('LoginPage has a title and buttons', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: MaterialApp(
          home: LoginPage(),
        ),
      ),
    );

    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Don\'t have an account? Signup'), findsOneWidget);
  });

  testWidgets('SignupPage has a title and buttons', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: MaterialApp(
          home: SignupPage(),
        ),
      ),
    );

    expect(find.text('Signup'), findsOneWidget);
    expect(find.text('Signup'), findsOneWidget);
    expect(find.text('Already have an account? Login'), findsOneWidget);
  });

  testWidgets('HomePage has upload and view buttons', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => ImageProvider()),
        ],
        child: MaterialApp(
          home: HomePage(),
        ),
      ),
    );

    expect(find.text('Upload Image'), findsOneWidget);
    expect(find.text('View Images'), findsOneWidget);
  });

  testWidgets('UploadPage has a choose image button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ImageProvider()),
        ],
        child: MaterialApp(
          home: UploadPage(),
        ),
      ),
    );

    expect(find.text('Choose Image'), findsOneWidget);
  });

  testWidgets('DownloadPage displays a list of images', (WidgetTester tester) async {
    final imageProvider = ImageProvider();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => imageProvider),
        ],
        child: MaterialApp(
          home: DownloadPage(),
        ),
      ),
    );

    // Initially shows a loading indicator
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Simulate fetching images
    await tester.runAsync(() async {
      await imageProvider.fetchImages();
    });

    // Rebuild the widget
    await tester.pump();

    // Now it should display the images
    expect(find.byType(ListView), findsOneWidget);
  });
}
