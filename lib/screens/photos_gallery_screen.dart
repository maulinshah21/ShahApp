import 'package:flutter/material.dart';
import 'package:share/share.dart';

class PhotosGalleryScreen extends StatelessWidget {
  final List<String> imageUrls;

  PhotosGalleryScreen({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Gallery'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _shareImage(imageUrls[index]),
            child: Image.network(
              imageUrls[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  void _shareImage(String imageUrl) {
    Share.share(imageUrl);
  }
}
