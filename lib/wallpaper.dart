import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Wallpaper {
  String name;
  String imageUrl;

  Wallpaper({required this.name, required this.imageUrl});

  Wallpaper.fromMap(Map<String, dynamic> data)
      : name = data['name'],
        imageUrl = data['imageUrl'];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
    };
  }
}

class WallpaperList extends StatelessWidget {
  final CollectionReference wallpapersRef =
      FirebaseFirestore.instance.collection('wallpapers');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallpapers'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: wallpapersRef.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }

          List<Wallpaper> wallpapers = snapshot.data!.docs.map((doc) {
            return Wallpaper(
              name: doc['name'],
              imageUrl: doc['imageUrl'],
            );
          }).toList();

          return ListView.builder(
            itemCount: wallpapers.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(wallpapers[index].name),
                leading: Image.network(wallpapers[index].imageUrl),
              );
            },
          );
        },
      ),
    );
  }
}
