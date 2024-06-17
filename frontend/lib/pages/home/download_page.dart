import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/image_provider.dart';
import '../../widgets/image_card.dart';

class DownloadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Images'),
      ),
      body: FutureBuilder(
        future: Provider.of<ImageProvider>(context, listen: false).fetchImages(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('An error occurred!'));
          } else {
            return Consumer<ImageProvider>(
              builder: (ctx, imageProvider, _) => ListView.builder(
                itemCount: imageProvider.images.length,
                itemBuilder: (ctx, i) => ImageCard(image: imageProvider.images[i]),
              ),
            );
          }
        },
      ),
    );
  }
}
