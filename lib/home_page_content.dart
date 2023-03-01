import 'package:flutter/material.dart';
import 'package:rack/wallpaper_detail.dart';
import 'wallpaper.dart';

class HomePageContent extends StatelessWidget {
  final List<String> imageUrls;
  HomePageContent({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Wallpapers",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Expanded(child: WallpaperGrid(imageUrls: imageUrls)),
        ],
      ),
    );
  }
}

class WallpaperGrid extends StatelessWidget {
  final List<String> imageUrls;
  WallpaperGrid({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: imageUrls.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    WallpaperDetailPage(imageUrl: imageUrls[index]),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(imageUrls[index]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
