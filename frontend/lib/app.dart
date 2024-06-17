import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/image_provider.dart';
import 'pages/auth/login_page.dart';
import 'pages/auth/signup_page.dart';
import 'pages/home/home_page.dart';
import 'pages/home/upload_page.dart';
import 'pages/home/download_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ImageProvider()),
      ],
      child: MaterialApp(
        title: 'Black and White Image Filter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignupPage(),
          '/home': (context) => HomePage(),
          '/upload': (context) => UploadPage(),
          '/download': (context) => DownloadPage(),
        },
      ),
    );
  }
}
