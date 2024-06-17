import 'package:flutter/material.dart';
import '../models/image.dart';

class ImageCard extends StatelessWidget {
  final ImageModel image;

  ImageCard({required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(image.filename),
        subtitle: Text('Filtered: ${image.filteredFilename}'),
        leading: Image.network(
          'http://localhost:8000/images/download/${image.id}',
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}
