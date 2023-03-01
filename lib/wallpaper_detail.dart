import 'package:flutter/material.dart';

class WallpaperDetailPage extends StatelessWidget {
  final String imageUrl;

  const WallpaperDetailPage({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallpaper Detail'),
      ),
      body: Container(
        child: Image.network(imageUrl),
      ),
    );
  }
}
