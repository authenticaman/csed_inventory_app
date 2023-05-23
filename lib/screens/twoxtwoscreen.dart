import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class twoxtwoscreen extends StatefulWidget {
  const twoxtwoscreen({Key? key}) : super(key: key);

  @override
  State<twoxtwoscreen> createState() => _twoxtwoscreenState();
}

class _twoxtwoscreenState extends State<twoxtwoscreen> {
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return Padding(
      padding: const EdgeInsets.only(top: 140, left: 40, right: 40, bottom: 140),
      child: Column(
        children: [
          Expanded(
            child: RepaintBoundary(
              key: globalKey,
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('QRImages')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (!snapshot.hasData) {
                    return Text('No data available');
                  }

                  final documents = snapshot.data!.docs;

                  return StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      final doc = documents[index];
                      final imageUrl = doc['imageLink'];
                      final timestamp = doc['timestamp'];
                      final itemName = doc['ItemDesc'];

                      return Column(
                        children: [
                          Text(
                            '$itemName',
                            style: const TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 20,
                              color: Colors.purpleAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CachedNetworkImage(
                            imageUrl: imageUrl,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ],
                      );
                    },
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                    mainAxisSpacing: 12.0,
                    crossAxisSpacing: 12.0,
                  );
                },
              ),
            ),
          ),
          Row(
            children: [
              MaterialButton(
                onPressed: _saveGridToGallery,
                minWidth: 80.0,
                height: 45,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                color: Colors.deepPurple,
                child: const Text(
                  "SAVE GRID",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 100),
              MaterialButton(
                onPressed: _shareGrid,
                minWidth: 80.0,
                height: 45,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                color: Colors.deepPurple,
                child: const Text(
                  "SHARE GRID",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _saveGridToGallery() async {
    try {
      RenderRepaintBoundary boundary =
      globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? imageData = byteData?.buffer.asUint8List();

      if (imageData != null) {
        final result = await ImageGallerySaver.saveImage(imageData);
        if (result['isSuccess']) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Grid saved to gallery')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save grid')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save grid')),
        );
      }
    } catch (e) {
      print('Error saving grid image to gallery: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save grid')),
      );
    }
  }

  Future<void> _shareGrid() async {
    try {
      RenderRepaintBoundary boundary =
      globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? imageData = byteData?.buffer.asUint8List();

      if (imageData != null) {
        // Save image to temporary directory
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;
        File imageFile = File('$tempPath/grid.png');
        await imageFile.writeAsBytes(imageData);

        // Share the image file
        await Share.shareFiles([imageFile.path], text: 'Share Grid');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to share grid')),
        );
      }
    } catch (e) {
      print('Error sharing grid image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to share grid')),
      );
    }
  }
}
