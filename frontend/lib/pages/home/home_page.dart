import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/upload');
              },
              child: Text('Upload Image'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/download');
              },
              child: Text('View Images'),
            ),
          ],
        ),
      ),
    );
  }
}
